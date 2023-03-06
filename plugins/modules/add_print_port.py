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
module: add_print_port
short_description: Install printer port
description: 
  - Adds printer port.
options:
  port_address:
    description:
      - Ip address
    required: true

  port_name:
    description:
      - name of port
    required: false

  protocol:
    description:
      - protocol
    required: false

  snmp:
    description:
      - snmp
    required: false
    
  state:
    description:
      - state
    required: true

author: Dan Eckholm // IT-Pappa
'''

EXAMPLES = r'''
- name: "Install Printer port"
  add_print_port:
    port_address: "10.54.10.100"
    port_name: CEO_Printer
    snmp: public3
    state: present
'''