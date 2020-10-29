
#include <Adafruit_NeoPixel.h>

#define LED_PIN    6
#define SWITCH_PIN 7 // when pulled low, flash is enabled

#define LED_COUNT 12

Adafruit_NeoPixel strip(LED_COUNT, LED_PIN, NEO_GRB + NEO_KHZ800);

void setup() {
  strip.begin();
  strip.show();
  strip.setBrightness(50);
  pinMode(SWITCH_PIN, INPUT_PULLUP);
}

// set all pixels to given color
void setAll(uint32_t color) {
  for (int i = 0; i < 12; i++) {
    strip.setPixelColor(i, color);
    strip.show();
  }
}


void loop() {
  int switchState = digitalRead(SWITCH_PIN);
  if (switchState == LOW) {
    setAll(strip.Color(255, 255, 255));
    delay(5000);
  } else {
    setAll(strip.Color(0, 0, 0));
    delay(500);
  }
}
