#include <Firmata.h>

byte previousPIN[TOTAL_PORTS];
byte previousPORT[TOTAL_PORTS]; 
byte analogPin = 0;

void outputPort(byte portNumber, byte portValue) {
    if (previousPIN[portNumber] != portValue) {
        Firmata.sendDigitalPort(portNumber, portValue); 
        previousPIN[portNumber] = portValue;
    }
}

void analogWriteCallback(byte pin, int value) {
    if (IS_PIN_PWM(pin)) {
        pinMode(PIN_TO_DIGITAL(pin), OUTPUT);
        analogWrite(PIN_TO_PWM(pin), value);
    }
}

void setPinModeCallback(byte pin, int mode) {
    if (IS_PIN_DIGITAL(pin)) {
        pinMode(PIN_TO_DIGITAL(pin), mode);
    }
}

void digitalWriteCallback(byte port, int value) {
    byte i;
    byte currentPinValue, previousPinValue;

    if (port < TOTAL_PORTS && value != previousPORT[port]) {
        for(i=0; i<8; i++) {
            currentPinValue = (byte) value & (1 << i);
            previousPinValue = previousPORT[port] & (1 << i);
            if(currentPinValue != previousPinValue) {
                digitalWrite(i + (port*8), currentPinValue);
            }
        }
        previousPORT[port] = value;
    }
}

void setup() {
    Firmata.setFirmwareVersion(0, 1);
    Firmata.attach(DIGITAL_MESSAGE, digitalWriteCallback);
    Firmata.attach(SET_PIN_MODE, setPinModeCallback);
    Firmata.attach(ANALOG_MESSAGE, analogWriteCallback);
    Firmata.begin(57600);
}

void loop() {
    byte i;

    for (i=0; i<TOTAL_PORTS; i++) {
        outputPort(i, readPort(i, 0xff));
    }

    while(Firmata.available()) {
        Firmata.processInput();
    }
    
    Firmata.sendAnalog(analogPin, analogRead(analogPin)); 
    analogPin = analogPin + 1;
    if (analogPin >= TOTAL_ANALOG_PINS) analogPin = 0;
}
