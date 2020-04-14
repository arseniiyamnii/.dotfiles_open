#!/bin/bash
uptime | awk -F'( | |:)+' '{print $4" days " $6}'
