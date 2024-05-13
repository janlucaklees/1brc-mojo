#
#  Copyright 2023 The original authors
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#

from collections import Dict
from math import min, max, abs
from python import Python

fn main() raises:
    var map = Dict[String, List[Int]]()

    with open("measurements.txt", "r") as file:
        var content = file.read()
        var lines = content.split("\n")

        for i in range(len(lines) -1):
            var line = lines[i]
            var temp: Int
            var locationName: String
            var offset = -1

            # Get the digit after the dot of the temperature
            temp = atol(line[offset])
            offset -= 1

            # Skip the dot
            offset -= 1

            # Get the least significant digit of temperature, skipping the dot.
            temp += atol(line[offset]) * 10
            offset -= 1

            # Check if there is another, more significant digit in the temperature and get the sign.
            if line[offset] != '-' and line[offset] != ';':
                temp += atol(line[offset]) * 100
                offset -= 1
            
            # Get the sign and determine the end of the string.
            if line[offset] == '-':
                temp *= -1
                offset -= 1
            
            locationName = line[0:offset]

            if locationName not in map:
                map[locationName] = List(1, temp, temp, temp)
            else:
                # Increase the count of the measurements
                map[locationName][0] += 1
                # Update the sum
                map[locationName][1] += temp
                # Update the maximum temperature
                map[locationName][2] = max(map[locationName][2], temp)
                # Update the minimum temperature
                map[locationName][3] = min(map[locationName][3], temp)

    var orderedLocations = Python.list()
    for entry in map.items():
        orderedLocations.append(entry[].key)
    orderedLocations.sort()

    print("{", end = "")
    var sep = ""
    for orderedLocation in orderedLocations:
        var location = orderedLocation
        var data = map[location]
      
        var min = data[3]
        var min_abs = abs(min)
        var min_negator = "" if min == min_abs else "-"

        var max = data[2]
        var max_abs = abs(max)
        var max_negator = "" if max == max_abs else "-"

        var count = data[0]
        var sum = data[1]
        var sum_abs = abs(sum)
        
        # Calculate average and round mathematically
        var avg_abs = (sum_abs * 10) // count
        avg_abs = avg_abs // 10 if avg_abs % 10 < 5 else avg_abs // 10 + 1
        var avg_negator = "" if sum == sum_abs else "-"

        print(sep, location, "=",
            min_negator, min_abs // 10, ".", min_abs % 10, "/",
            avg_negator, avg_abs // 10, ".", avg_abs % 10, "/",
            max_negator, max_abs // 10, ".", max_abs % 10,
            sep = "", end = "")

        sep = ", "
    print("}")
# 0m15.392s