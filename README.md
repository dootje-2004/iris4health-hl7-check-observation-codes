# HL7 Routing Rule example: Validate codes in a repeating OBX segment

This example checks HL7 messages with OBX segments passing through an IRIS production for valid observation codes and routes them accordingly.

## Prerequisites

We presume basic knowledge of IRIS interoperability (e.g. the training *Developing System Integrations* or *Building HL7 Integrations*).

## Installation

If you want to run this example in a Docker environment, clone this repo and run `docker-compose up -d`. It uses the IRIS4Health Community Edition, so there is no need for a license key.
Otherwise, have an IRIS4Health instance running and create an interoperability-enabled namespace in it.

In either case, import the file *RepeatingField.xml* into the interoperability namespace and compile it.
You can use the Studio IDE or the Management Portal (System Explorer > Classes > Import).

Configure the *FilePath* and *ArchivePath* settings of *HL7FileService* to point to existing folders on your machine. Docker environments should have a folder `ext` in the project root.
Similarly, configure the *FilePath* setting of the *HL7FileOperation* and *BadMessageHandler* business operations.

## Running the example

In the Management Portal, navigate to  *Interoperability* > *Configure Production* > *Open* (in the *Actions* tab on the right).
Select *HL7.Production* and start it.

Copy any of the sample files from *HL7Messages* into the *HL7FileService*'s input folder and inspect their message traces to see the routing rule in action.

## What does this example do?

The essential part of this example is the utility function *ValidateObservationCodes*.
This function parses a string of observation codes and looks up each value in the *ValidOBXCodes* Data Lookup Table.
If an invalid code is found, the message is sent to a *BadMessageHandler* business operation.
If all codes pass, the message is sent to the *HL7FileOperation* business operation.

The message router *MsgRouter* accepts ADT_A08 and ORU_R01 messages of HL7 version 2.5.
Other message types or versions are discarded.
