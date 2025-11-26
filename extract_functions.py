#!/usr/bin/env python3
import json
import os
import re
from collections import defaultdict

# Load target functions
with open('target-functions.json', 'r') as f:
    target_functions_data = json.load(f)

# Load contracts to cover
with open('magic/coverage/contracts-to-cover.json', 'r') as f:
    contracts_to_cover = json.load(f)['contracts']

# Function to normalize function name from filename
def normalize_function_name(filename):
    """Extract function name from filename like 'function_claimBribes_struct_IBribeInitiative.ClaimData[].md'"""
    if not filename.startswith('function_'):
        return None
    # Remove 'function_' prefix and '.md' suffix
    name = filename[9:-3]
    # Extract just the function name before parameters
    parts = name.split('_', 1)
    if len(parts) > 0:
        return parts[0]
    return None

def parse_call_tree(file_path):
    """Parse a function call tree file and extract all called functions"""
    touched_functions = defaultdict(set)
    
    try:
        with open(file_path, 'r') as f:
            content = f.read()
            
        # Pattern to match function calls: FUNCTION: ContractName.functionName
        # Also matches CONSTRUCTOR and MODIFIER
        function_pattern = r'(?:⚙️ FUNCTION|🏗️ CONSTRUCTOR|🔒 MODIFIER):\s+([A-Za-z0-9_]+)\.([A-Za-z0-9_]+)'
        
        matches = re.findall(function_pattern, content)
        
        for contract, function in matches:
            touched_functions[contract].add(function)
    
    except Exception as e:
        print(f"Error parsing {file_path}: {e}")
    
    return touched_functions

# Main function to extract all touched functions
def extract_all_touched_functions():
    all_touched = defaultdict(set)
    
    # For each contract in contracts-to-cover
    for contract_name in contracts_to_cover:
        print(f"\nProcessing contract: {contract_name}")
        
        # Get target functions for this contract
        if contract_name not in target_functions_data:
            print(f"  No target functions found for {contract_name}")
            continue
            
        target_funcs = target_functions_data[contract_name]['target_functions']
        print(f"  Target functions: {target_funcs}")
        
        # Find the contract directory
        contract_dir = f"context_output/src/{contract_name}.sol"
        if not os.path.exists(contract_dir):
            print(f"  Directory not found: {contract_dir}")
            continue
        
        # Process each target function
        for target_func in target_funcs:
            # Normalize the target function name (remove parameters)
            target_func_name = target_func.split('(')[0]
            print(f"  Looking for function: {target_func_name}")
            
            # Find matching function file
            for filename in os.listdir(contract_dir):
                if not filename.startswith('function_'):
                    continue
                
                func_name = normalize_function_name(filename)
                if func_name == target_func_name:
                    file_path = os.path.join(contract_dir, filename)
                    print(f"    Found file: {filename}")
                    
                    # Parse the call tree
                    touched = parse_call_tree(file_path)
                    
                    # Merge into all_touched
                    for contract, functions in touched.items():
                        all_touched[contract].update(functions)
                    
                    break
    
    return all_touched

# Check if a contract is an interface or library
def is_interface_or_library(contract_name):
    """Check if a contract is an interface or library by searching for its definition"""
    # Common interface prefixes
    if contract_name.startswith('I') and contract_name[1].isupper():
        return True
    
    # Search in src files
    for root, dirs, files in os.walk('src'):
        for file in files:
            if not file.endswith('.sol'):
                continue
            file_path = os.path.join(root, file)
            try:
                with open(file_path, 'r') as f:
                    content = f.read()
                    # Check for interface or library declaration
                    if re.search(rf'\binterface\s+{contract_name}\s*{{', content):
                        return True
                    if re.search(rf'\blibrary\s+{contract_name}\s*{{', content):
                        return True
            except:
                pass
    
    return False

# Excluded base contracts (Ownable, ReentrancyGuard, etc.)
EXCLUDED_CONTRACTS = {
    # OpenZeppelin
    'ERC1967Proxy', 'TransparentUpgradeableProxy', 'UUPSUpgradeable', 'BeaconProxy', 
    'Proxy', 'ERC1967Upgrade', 'Initializable', 'ProxyAdmin', 'UpgradeableBeacon',
    'ReentrancyGuard', 'ReentrancyGuardUpgradeable',
    'Ownable', 'Ownable2Step', 'OwnableUpgradeable', 'AccessControl', 
    'AccessControlEnumerable', 'AccessControlDefaultAdminRules', 
    'AccessControlUpgradeable', 'AccessManaged', 'Authority',
    'Clones',  # OpenZeppelin Clones library
    # Solmate
    'Auth', 'Owned', 'RolesAuthority', 'MultiRolesAuthority',
    # Solady
    'OwnableRoles',
    # Test utilities
    'StdInvariant', 'StdAssertions', 'StdUtils', 'Test',
    'CryticAsserts', 'FoundryAsserts',
    # Other common bases
    'Context', 'ERC165', 'Pausable', 'ERC20', 'ERC721',
    'MockERC20', 'MockERC721',
    # Console
    'console', 'console2',
    # Free functions (file-level functions, not belonging to any contract)
    'Unknown'
}

def should_exclude_contract(contract_name):
    """Check if a contract should be excluded"""
    if contract_name in EXCLUDED_CONTRACTS:
        return True
    if is_interface_or_library(contract_name):
        return True
    return False

# Extract and filter
print("Extracting touched functions...")
all_touched = extract_all_touched_functions()

# Filter out interfaces, libraries, and excluded contracts
filtered_touched = {}
for contract, functions in all_touched.items():
    if not should_exclude_contract(contract):
        filtered_touched[contract] = sorted(list(functions))
        print(f"\nIncluding contract: {contract}")
        print(f"  Functions: {filtered_touched[contract]}")
    else:
        print(f"\nExcluding contract: {contract} (interface/library/base)")

# Format output
output = {}
for contract in sorted(filtered_touched.keys()):
    output[contract] = {
        "functions_to_cover": filtered_touched[contract]
    }

# Create magic directory if it doesn't exist
os.makedirs('magic', exist_ok=True)

# Write output
output_file = 'magic/functions-to-cover.json'
with open(output_file, 'w') as f:
    json.dump(output, f, indent=2)

print(f"\n\nOutput written to: {output_file}")
print(f"Total contracts: {len(output)}")
print(f"Contracts: {sorted(output.keys())}")
