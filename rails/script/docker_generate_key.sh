#!/bin/bash

echo "delete and recreate new master.key..."
rm -fr config/credentials.yml.enc
EDITOR="mate --wait" rails credentials:edit
