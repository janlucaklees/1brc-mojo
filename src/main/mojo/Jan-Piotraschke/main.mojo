from tensor import Tensor
from python import Python


fn parse_float(raw_num: String) -> Float64:
    var seperator_pos = raw_num.find(".")
    if seperator_pos == -1:
        seperator_pos = len(raw_num)
    var leading_digit_count: Int = int(seperator_pos)

    var digit_iter = 0
    var float_num = 0.0
    var len_raw_num: Int = len(raw_num)
    for i in range(len_raw_num):
        var single_str: String = raw_num[i]
        if single_str != ".":
            try:
                var digit: Int = int(single_str)
                if digit_iter < leading_digit_count:
                    float_num = float_num + digit * (
                        10 ** (leading_digit_count - 1 - digit_iter)
                    )
                else:
                    float_num = float_num + digit / (
                        10 ** (-(leading_digit_count - 1 - digit_iter))
                    )

                digit_iter = digit_iter + 1
            except ValueError:
                print("Invalid number format")
                break

    return float_num


fn main():
    var n: Int = 10
    var x = Tensor[DType.float32](n)

    try:
        with open("src/test/resources/samples/measurements-1.txt", "r") as f:
            # Read the file
            var raw_data: String = f.read().rstrip()

            # Parse the data
            var data_seperator_pos: Int = raw_data.find(";")
            var location: String = raw_data[:data_seperator_pos]
            var raw_num: String = raw_data[data_seperator_pos + 1 :]

            var float_num: Float64 = parse_float(raw_num)
            print(location, " has the temperatur of ", float_num, " degrees.")

    except IOError:
        print("File not found")
