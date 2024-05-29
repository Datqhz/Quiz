#!/bin/bash

set -e
run_cmd="dotnet Quiz.MyUser.Service.dll"

# Wait for the MySQL server to be available
until dotnet ef database update -c UserServiceContext; do
>&2 echo "MySQL is starting up"
sleep 1
done

>&2 echo "MySQL is up - executing command"
exec $run_cmd