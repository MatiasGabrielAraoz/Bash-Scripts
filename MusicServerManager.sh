SERVER_NAME="music-server"
SERVER_STATUS=$(docker ps | grep $SERVER_NAME)
help() {
echo "Commands: \n
start: starts the server if isn't running
stop: stops the server if is running
status: displays the server status"
}

if [[ "$1" = "" || "$1" = " " ]]; then
	help
fi

if [[ "$1" = "start" ]]; then
	if [[ $SERVER_STATUS ]]; then
		echo "Server Already running"
		exit 1

	else
		docker start $SERVER_NAME
		echo "Server Started"

	fi
fi

if [[ "$1" = "stop" ]]; then
	if [[ $SERVER_STATUS ]]; then
		docker stop $SERVER_NAME
		echo "Server stopped"
	else
		echo "The server is already not running"
		exit 1
	fi
fi
if [[ "$1" = "status" ]]; then
	if [[ $SERVER_STATUS ]]; then
		echo "Server Running"
	else
		echo "Server is not running"
	fi
fi
if [[ "$1" = "help" ]]; then
	help 
fi
