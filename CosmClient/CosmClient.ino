#include <SPI.h>
#include <Ethernet.h>
#include <HttpClient.h>
#include <Cosm.h>

// MAC address for your Ethernet shield
byte mac[] = { 0x90, 0xA2, 0xDA, 0x0D, 0xB1, 0x91 };

// Your Cosm key to let you upload data
char cosmKey[] = "sAdPbfxoqvOw8A-A-10QTUhh78CSAKw0bmw1b2N3bG5Vcz0g";

// Analog pin which we're monitoring (0 and 1 are used by the Ethernet shield)
int sensorPin = 2;

// Define the strings for our datastream IDs
char sensorId[] = "sensor_reading";
CosmDatastream datastreams[] = {
  CosmDatastream(sensorId, strlen(sensorId), DATASTREAM_FLOAT),
};
// Finally, wrap the datastreams into a feed
CosmFeed feed(97411, datastreams, 1 /* number of datastreams */);

EthernetClient client;
CosmClient cosmclient(client);

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  
  Serial.println("Starting single datastream upload to Cosm...");
  Serial.println();

  while (Ethernet.begin(mac) != 1)
  {
    Serial.println("Error getting IP address via DHCP, trying again...");
    delay(15000);
  }
}

void loop() {
  int sensorValue = analogRead(sensorPin);
  datastreams[0].setFloat(sensorValue);

  Serial.print("Read sensor value ");
  Serial.println(datastreams[0].getFloat());

  Serial.println("Uploading it to Cosm");
  int ret = cosmclient.put(feed, cosmKey);
  Serial.print("cosmclient.put returned ");
  Serial.println(ret);

  Serial.println();
  delay(15000);
}
