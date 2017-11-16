#!/usr/bin/env python


from __future__ import print_function

import boto3, argparse, time, prettytable, subprocess, os, sys


# Take the command line argument and make sure it is valid, send to lowercase
parser = argparse.ArgumentParser(prog='Connect-AwsEc2Ssh', description="Display a list of available linux instances in your AWS account and SSH to them")
parser.add_argument('-r','--region', help="A valid region to search for instances in (e.g. us-west-2, us-east-1)")
parser.add_argument('-e','--environment', help="A valid environment to search for instances in (HP, Beacon, OPS)")
parser.add_argument('-n','--name',help="A specific instance name to search for")
arg = parser.parse_args()

#Check to see if Region variable was passed
instanceRegion = []
if arg.region:
    instanceRegion.append(arg.region)
else:
    instanceRegion = ['us-east-1','us-west-2','eu-central-1']

#Santize input
if arg.environment:
    options = {
        'ops': 'OPS',
        'beacon': 'Beacon',
        'hp': 'HP',
    }

#Create a list of ALL linux instance dictionaries
linuxInstances = []
for region in instanceRegion:
    ec2Client = boto3.client('ec2', region_name = region)
    if arg.environment and not arg.name:
        filter = [{'Name': 'tag:Environment','Values': ['*' + arg.environment.lower() + '*']}]

    ec2Instances = ec2Client.describe_instances()
    for key in ec2Instances['Reservations']:
        for i in key['Instances']:
            if not arg.environment and not arg.name:
                if not i.has_key('Platform'):
                    linuxInstances.append(i)
            elif arg.environment and not arg.name:
                if not i.has_key('Platform'):
                    for e in i['Tags']:
                        if e['Key'] == 'Environment' and arg.environment.lower() in e['Value'].lower():
                            linuxInstances.append(i)
            elif arg.name and not arg.environment:
                for n in i['Tags']:
                    if n['Key'] == 'Name' and arg.name.lower() in n['Value'].lower() and not i.has_key('Platform'):
                        linuxInstances.append(i)
            elif arg.name and arg.environment:
                for e in i['Tags']:
                    if e['Key'] == 'Environment' and arg.environment.lower() in e['Value'].lower() and not i.has_key('Platform'):
                        for n in i['Tags']:
                            if n['Key'] == 'Name' and arg.name.lower() in n['Value'].lower():
                                linuxInstances.append(i)

#Build a nice looking table to display of connection information
if len(linuxInstances) == 0:
    print("No Instances returned that match input arguments, exiting")
    sys.exit()


p = prettytable.PrettyTable()
p.field_names = ['#', 'Name', 'Environment', 'PrivateIpAddress', 'KeyName', 'State']
count = 0
connections = {}
for i in linuxInstances:
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

sshHost = raw_input("SSH To: ")
connList = connections.get(int(sshHost))

#Ask for a different user to SSH as, default is self.  Set a suitable key to use
sshUser = raw_input("As User (default is \'nloiselle\'): ")

if not sshUser.strip():
    sshUser = 'nloiselle'
    sshKey = os.environ['HOME'] + "/Keys/id_rsa"
else:
    sshKey = os.environ['HOME'] + "/Keys/" + connList[3] + ".pem"
    #if connList[3] == 'jatwaterkey':
        #sshKey = os.environ['HOME'] + "/Keys/jatwaterkey\ \(AWS\ N.Virginia\).pem"
    #else:
        #sshKey = os.environ['HOME'] + "/Keys/" + connList[3] + ".pem"

sshCmd = "ssh -i " + sshKey + " " + sshUser + "@" + connList[2]
print(sshCmd)
#Generate AppleScript to open a new iTerm tab and make the SSH connection in it
script = '''
tell application "iTerm"
    tell current window
        create tab with default profile command "%s"
        tell current session
            set name to "%s"
        end tell
    end tell
end tell
''' % (sshCmd, connList[0])

appleScript = subprocess.Popen(['osascript'], stdin=subprocess.PIPE, stdout=subprocess.PIPE)

sys.exit(appleScript.communicate(script))
