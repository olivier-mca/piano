# find the Arduino port
ARDUINO_UPLOAD_PORT="$(find /dev/cu.usbmodem* | head -n 1)"

if [ "${ARDUINO_UPLOAD_PORT}" != "" ]
then

	# reset the Arduino
	stty -f "${ARDUINO_UPLOAD_PORT}" 1200

	# wait for it...
	echo "Looking for Device..."
	sleep 4
	#while :; do
	#	sleep 0.5
	#	ARDUINO_UPLOAD_PORT2="$(find /dev/cu.usbmodem1* | head -n 1)"
	#	[ -c "${ARDUINO_UPLOAD_PORT2}" ] && break
	#done
	ARDUINO_UPLOAD_PORT2="$(find /dev/cu.usbmodem1* | head -n 1)"

	echo "found on port : ${ARDUINO_UPLOAD_PORT2}"
	# ...upload!
	echo "Upgrading Device..."
	./files/avrdude/6.3.0-arduino9/bin/avrdude -Cfiles/avrdude.conf -patmega32u4 \
	-cavr109 -P${ARDUINO_UPLOAD_PORT2} -b57600 -D -Uflash:w:files/R13_MASTER.hex:i
	echo "Done"
else
    echo "ERROR : No device found to upgrade"
fi
