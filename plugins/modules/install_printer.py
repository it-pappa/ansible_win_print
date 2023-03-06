#!/usr/bin/python
# -*- coding: utf-8 -*-

# (c) 2022, Dan Eckholm <@it-pappa>
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.


DOCUMENTATION = r'''
---
module: install_printer
short_description: install printer
description: 
  - installs printer
options:
    printer_name:
        description:
            - name of printer
        required: true

    port_name:
        description:
            - portname or ip-address of printer
        required: true

    comment:
        description:
            - comment
        required: false

    location:
        description:
            - location
        required: false

    shared:
        description:
            - shared
        required: true
        
    share_name:
        description:
            - share_name
        required: false

    printer_driver:
        description:
            - which driver
        required: true

    paper_size:
        description:
            - papersize
        required: true

    color:
        description:
            - color
        required: false

    duplexmode:
        description:
            - duplexmode
        required: false

    state:
        description:
            - state
        required: true


author: Dan Eckholm // IT-Pappa
'''

EXAMPLES = r'''
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


'''