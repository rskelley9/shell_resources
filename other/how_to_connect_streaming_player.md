## About

[gist](https://gist.github.com/rskelley9/e9fbfe02147cd8f9f7f9)

I recently relocated for new employment. I've been staying in an extended stay hotel for about 3 weeks now. The hotel I'm staying in gives its guests free Wifi access. However, it requires users to accept terms and conditions on a splash page via browser interface before they can use the network. This makes it difficult to use my Chromecast with the network, as it doesn't have a means of accessing tht splash page. While I could call the IT help line, I decided to explore a work-around.

Like many networks, my hotel's network attempts to improve security by using MAC address filtering. Luckily, Mac OS X (10.4 - 10.10) makes it very easy to spoof your network card's MAC address.

Here's how to add a devices like Chromecast, AppleTV, Roku to a wireless network that requires a browser to authenticate and accept terms and conditions.

## Before You Start

You'll need two things besides the device you want to connect to the network, (1) your laptop and (2) some Unix shell flavor.

If you don't have any idea what a MAC address is, [see my Gist on MAC Address Spoofing](https://gist.github.com/rskelley9/38fe08be915c75359e9e). Really, there are just two important points you should know about MAC addresses before proceeding:

1.) MAC addresses are 48-bit, factory-assigned, hexadecimal uids used for organizing a physical network.

2.) MAC addresses will typically be reset once your computer/device reboots.

## Steps

1.) Open up Terminal.app and run the following command to list your machine's *active* network interface:
```
# Should output something like 'en0' or 'en1' depending on wireless/wired connection
$ ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active' | egrep -o -m 1 '^[^\t:]+'
```

2.) Show the MAC address for the interface name you retrieved in step 1, `en0` in this example:
```
$ ifconfig en0 | grep ether
```
3.) Store that value in a variable so you can easily set your MAC address back to its original value without rebooting your computer.
```
mymac=$(ifconfig en0 | grep ether)
```

4.) Turn your chromecast/other device on and configure it to connect to the network. [Find the devices MAC address and copy it down](http://www.tomsguide.com/us/google-chromecast-mac-address,news-18307.html).

5.) Disconnect your computer from the network and turn off your wireless controller:
```
# First disassociate from your wireless network
$ sudo airport -z

# Then turn the network interface controller (NIC) off
$ sudo ifconfig en0 down
```

6.) Turn your NIC back on, and set your the your network card's MAC address to the Chromecast's (xx:xx:xx:xx:xx:xx in this example):
```
# Turn on the NIC
$ sudo ifconfig en0 up

# Change MAC address of your computer to Chromecast's
$ sudo ifconfig en0 xx:xx:xx:xx:xx:xx
```

**Note:** If you get a 'bad value' message or your MAC address isn't being set to the new value you generated, you may have to specifiy another name for the interface.
```
# Try using 'ether' for OS X 10.9 and 10.10
$ sudo ifconfig en0 ether xx:xx:xx:xx:xx:xx

# Try using 'Wi-Fi for OS X prior to 10.8'
$ sudo ifconfig en0 Wi-Fi xx:xx:xx:xx:xx:xx
```

7.) Turn off your Chromecast. Then, open your laptop's browser, accept the splash page terms and conditions and log onto the network while using the Chromecast's MAC address.

8.) Repeat step 5, disassociating from the network on your laptop and turning the NIC off.

9.) Turn your Chromecast on, and it should automatically connect to the wireless network.

10.) On your laptop, change your MAC address back to it's default:
```
sudo ifconfig en0 ether ${mymac}
```

## Also...

* Use `arp -a -n` to list all of the machines on your LAN. This should out their MAC and their IP/Host. You can probably guess why this is useful...

