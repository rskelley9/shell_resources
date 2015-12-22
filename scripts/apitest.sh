if [ -z "$2" ]; then
	echo syntax: sh apitest.sh '<apipath> <postdata> [envvar_replace] [jq_query] [envvar]'
else
	if [ -z "$3" ]; then
		resp=$(curl -sS -X POST ${apiurl}/$1 -H 'Content-Type: application/json' -d "$2")
	else
		# 3rd param replaces tag in json file with value of env var
		json=$(cat "$2")
		for var in $(echo $3 | tr "," " "); do
			json=$(echo "$json" | sed "s/-$var-/${!var}/g")
		done
		resp=$(echo "$json" | curl -sS -X POST ${apiurl}/$1 -H 'Content-Type: application/json' -d @-)
	fi

	if [ -z "$4" ]; then
		echo $resp
	else
		# 4th jq filter
		if [ -z "$5" ]; then
			echo $resp | jq -r $4
		else
			# 5th sets an env var with value
			export $5="$(echo $resp | jq -r $4)"
			echo "${!5}"
		fi
	fi
fi