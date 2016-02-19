#!/usr/bin/env lua

require 'manifest'

m = Manifest.create("manifest.txt")
str = "Sample-Project>1.0,>1.0,<=2.0"
p = m:parse(str)
m:printparse(p)
str = "Sample-Project>=1.0,>1.0,<=2.0"
p = m:parse(str)

