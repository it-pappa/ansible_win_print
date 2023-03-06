# Ansible Collection - it_pappa.win_print

The `win_print` collection includes the modules to install, remove and configure printers and ports on windows servers. 

## Ansible version compatibility

This collection has been tested against following Ansible versions: **>=2.12**.

Plugins and modules within a collection may be tested with only specific Ansible versions.
A collection may contain metadata that identifies these versions.

## Collection Documentation
If you use the Ansible package and don't update collections independently, use **latest**, if you install or update this collection directly from Galaxy.

## Installation and Usage

### Installing the Collection from Ansible Galaxy

Before using the win_print collection, you need to install it with the `ansible-galaxy` CLI:

    ansible-galaxy collection install it_pappa.win_print

You can also include it in a `requirements.yml` file and install it via `ansible-galaxy collection install -r requirements.yml` using the format:

```yaml
collections:
- name: it_pappa.win_print
  version: 1.0.0
```

### Example Playbook
Example Playbook with all variables: 
```yaml
    ---
    - name: "Install Printer port"
        add_print_port:
        port_address: "10.54.10.100"
        port_name: CEO_Printer
        snmp: public3
        state: present

    - name: "Install Printer port"
      install_printer:
        name: "canon-test"
        printer_driver: generic / text only
        port_name: 10.64.10.100"
        comment: "a comment"
        location: "Hamburg"
        shared: true
        share_name: "CEO/BDE Office Printer"
        paper_size: "A4"
        color: false
        duplexmode: "twosidedlongedge"
        state: present
```

## Contributing to this collection

If you find problems, please open an issue [it_pappa.win_print](https://github.com/it-pappa/ansible_win_print). 

## License

GNU General Public License v3.0 or later
