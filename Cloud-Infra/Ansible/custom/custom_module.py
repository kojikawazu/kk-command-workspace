#!/usr/bin/env python3

import re
from ansible.module_utils.basic import AnsibleModule

def main():

    module_args = dict(
        input_file=dict(type='str', required=True)
    )
    module = AnsibleModule(
        argument_spec=module_args,
        supports_check_mode=True
    )

    input_file = module.params['input_file']
    with open(input_file, 'r') as f:
        html = f.read()

    # Convert all lowercase characters to uppercase
    html = re.sub(r'[a-z]', lambda m: m.group(0).upper(), html)

    # Save modified HTML to the same file
    with open(input_file, 'w') as f:
        f.write(html)

    module.exit_json(changed=True, result=input_file)

if __name__ == '__main__':
    main()