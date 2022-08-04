#include <Arduino.h>
#include <Wire.h>
#include <SPI.h>
#include <ArduinoBLE.h>
#include <Arduino_LSM6DSOX.h>
#include <vl53lx_class.h>
#include <arducam.h>

void setup() {
  Serial.begin(115200);
}

void loop() {
  Serial.write("ok", 2);
  sleep_ms(1000);
}
