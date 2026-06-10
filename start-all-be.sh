#!/bin/bash

echo "Starting All Microservices..."

# Get the directory of the script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

echo "Starting Backend Api.."
(cd "$DIR/backend/api" && dotnet run --urls=http://localhost:5000) &
PID1=$!

echo "Starting RealtimeChat .."
(cd "$DIR/backend/realTimeChat" && dotnet run --urls=http://localhost:8001) &
PID2=$!

echo "Starting RealtimeNotification.."
(cd "$DIR/backend/realtimeNotification" && dotnet run --urls=http://localhost:8088) &
PID3=$!

echo "All services started."
echo "Press Ctrl+C to exit this launcher and stop all services..."

# Trap Ctrl+C to kill all background processes
trap "echo 'Stopping services...'; kill $PID1 $PID2 $PID3 2>/dev/null; exit" SIGINT

# Wait for all background processes
wait $PID1 $PID2 $PID3
