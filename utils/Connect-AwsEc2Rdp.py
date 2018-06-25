#!/usr/bin/env python


from __future__ import print_function

import boto3, argparse, time, prettytable, subprocess, os, sys


# Take the command line argument and make sure it is valid, send to lowercase
parser = argparse.ArgumentParser(prog='Connect-AwsEc2Rdp', description="Display a list of available Windows instances in your AWS account and RDP to them")
parser.add_argument('-r','--region', help="A valid region to search for instances in (e.g. us-west-2, us-east-1)")
parser.add_argument('-e','--environment', help="A valid environment to search for instances in (HP, Beacon, OPS)")
parser.add_argument('-n','--name',help="A specific instance name to search for")
arg = parser.parse_args()

#Check to see if Region variable was passed
instanceRegion = []
if arg.region:
    instanceRegion.append(arg.region)
else:
    instanceRegion = ['us-east-1','us-west-2']

#Create a list of ALL Windows instance dictionaries
windowsInstances = []

filters = [{'Name': 'platform', 'Values': ['windows']}]
if arg.environment:
    filters.append({'Name': 'tag:Environment', 'Values': [arg.environment]})
if (arg.name):
    filters.append({'Name': 'tag:Name', 'Values': ['*' + arg.name + '*']})
    
for region in instanceRegion:
    ec2Client = boto3.client('ec2', region_name = region)
    ec2Instances = ec2Client.describe_instances(Filters=filters)
    for key in ec2Instances['Reservations']:
        for i in key['Instances']:
            windowsInstances.append(i)

if len(windowsInstances) == 0:
    print("No Instances returned that match input arguments, exiting")
    sys.exit()

#Build a nice looking table to display of connection information
p = prettytable.PrettyTable()
p.field_names = ['#', 'Name', 'Environment', 'PrivateIpAddress', 'KeyName', 'State']
count = 0
connections = {}
for i in windowsInstances:
    count += 1
    for d in i['Tags']:
        if d['Key'] == 'Name':
            dName = d['Value']
        if d['Key'] == 'Environment':
            dEnv = d['Value']
    p.add_row([count, dName, dEnv, i.get('PrivateIpAddress', None), i['KeyName'], i['State']['Name']])
    #Create a dictionary of lists with the key being the count and the value being a list of connection information
    connInfo = [dName, dEnv, i.get('PrivateIpAddress', None), i['KeyName'], i['State']['Name']]
    connections[count] = connInfo

print(p)

rdpHost = input("RDP To: ")
conns = rdpHost.split(',')
conns = map(int, conns)
connList = []
for c in conns:
    connList.append(connections.get(c))

#Generate AppleScript to open a new RoyalTSX Ad-Hoc Connection
for a in connList:
    script = '''
    tell application "Royal TSX"
        activate
        adhoc "rdp://%s"
    end tell
    ''' % a[2]

    appleScript = subprocess.Popen(['osascript'], stdin=subprocess.PIPE, stdout=subprocess.PIPE)
    appleScript.communicate(script.encode())

sys.exit()
