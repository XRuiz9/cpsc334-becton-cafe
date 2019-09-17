import os

path = os.path.dirname(os.path.realpath(__file__))

os.system("Display=:1")
os.system("processing-java --force --sketch="+path+" --output="+path+"/out --run")