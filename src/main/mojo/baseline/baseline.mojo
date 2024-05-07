from tensor import Tensor
from python import Python

# fn main():
#     var n: Int = 10
#     var x = Tensor[DType.float32](n)

#     try:
#         with open("src/test/resources/samples/measurements-10.txt", "r") as f:
#             var data_str: List[String] = f.read().split("\n")
#             for i in range(n):
#                 var data_row = data_str[i]
#                 var parts = data_row.split(';')
#     except IOError:
#         print("File not found")

#     var greet_me: String = greet("world")
#     print(greet_me)
#     print("Baseline not yet implemented!")


fn parse_float(raw_num: String) -> Float64:
    var seperator_pos = raw_num.find(".")
    var seperator_pos_int: Int = int(seperator_pos)

    var n = 0
    var float_num = 0.0
    var len_raw_num: Int = len(raw_num)
    for i in range(len_raw_num):
        var single_str: String = raw_num[i]
        if single_str != ".":
            try:
                var single_int: Int = int(single_str)
                float_num = float_num + single_int * (
                    1 / (10 ** (n - seperator_pos_int + 1))
                )
                n = n + 1
            except ValueError:
                print("Invalid number format")
                break

    return float_num


fn main():
    var raw_string: String = "HH;1.42"

    var data_seperator_pos: Int = raw_string.find(";")

    var location: String = raw_string[:data_seperator_pos]
    var raw_num: String = raw_string[data_seperator_pos + 1 :]

    var float_num: Float64 = parse_float(raw_num)
    print(location, " has the temperatur of ", float_num, " degrees.")
