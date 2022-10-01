#!/bin/bash

# Wait for DB services
sh ./lib/docker/wait-for-services.sh

# Prepare DB (Migrate - If not? Create db & Migrate)
sh ./lib/docker/prepare-db.sh

# Start Application
bundle exec puma -C config/puma.rb