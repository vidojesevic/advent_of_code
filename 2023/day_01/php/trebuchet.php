<?php

require_once "../../../modules/modules.php";

echo "Advent of Code 2023!\nDay 1: Trebuchet\n"; 

// $file = fileRead("../test.txt");
$file = fileRead("../input.txt");
// var_dump($file);

$arr = explode("\n", $file);
array_pop($arr);

// $arrNum[$i] = preg_replace('/^[0-9]/', '', $arr[$i], 2);


function arrayOfInt($arr): array
{
    $arrNum = array();
    for ($i = 0; $i < count($arr); ++$i) {
        $temp = filter_var($arr[$i], FILTER_SANITIZE_NUMBER_INT);
        if (strlen($temp) == 2) {
            $arrNum[$i] = (int)$temp;
        }
        if (strlen($temp) > 2) {
            $len = strlen($temp);
            $temp = $temp[0] . $temp[$len - 1];
            $arrNum[$i] = (int)$temp;
        }
        if (strlen($temp) == 1) {
            $arrNum[$i] = (int)($temp . $temp);
        }
    }
    return $arrNum;
}

$arrNum = arrayOfInt($arr);

function calculateSum($arr): int
{
    $sum = 0;
    for ($i = 0; $i < count($arr); $i++) {
        $sum += $arr[$i];
    }
    return $sum;
}

$result = calculateSum($arrNum);
echo "Result of part one: " . $result . "\n";

echo "Part two:\n";

$numStr = [
    "1" => "one",
    "2" => "two",
    "3" => "three",
    "4" => "four",
    "5" => "five",
    "6" => "six",
    "7" => "seven",
    "8" => "eight",
    "9" => "nine"
];

// $partTwo = fileRead("../test2.txt");
$partTwo = fileRead("../input.txt");
$arrStr = explode("\n", $partTwo);
array_pop($arrStr);

// dirty scripting

function checkTemp($str): string {
    $len = strlen($str);
    if ($len > 2) {
        return $str[0] . $str[$len - 1];
    } 
    if ($len == 1) {
        return $str . $str;
    } 
    return $str;
}

function findNum($str, $strArr): string {
    if (filter_var($str, FILTER_SANITIZE_NUMBER_INT) != null) {
        $dig = filter_var($str, FILTER_SANITIZE_NUMBER_INT);
        return $dig;
    } else {
        foreach ($strArr as $key => $val) {
            if (str_contains($str, $val)) {
                return $key;
            }
        }
    }
    return "";
}

function arrayOfIntPartTwo($arr, $strArr): array
{
    $arrNum = array();
    $leftArr = array();
    $rightArr = array();
    $temp = "";
    $right = "";
    // correct
    for ($i = 0; $i < count($arr); $i++) {
        $slice = "";
        for ($k = 0; $k < strlen($arr[$i]); $k++) {
            $slice .= $arr[$i][$k];
            $temp = findNum($slice, $strArr);
            if ($temp != "") {
                // echo $arr[$i] . " => " . $temp . "\n";
                $leftArr[$i] = $temp;
                break;
            }
        }
        $slice = "";
        // echo "Left: " . $temp . " + " . $right . "\n";
    }
    for ($i = 0; $i < count($arr); $i++) {
        $slice = "";
        $k = strlen($arr[$i]) - 1;
        while ($k >= 0) {
            // echo "index: " . $k . "\n";
            $slice = $arr[$i][$k] . $slice;
            // echo "Slice: " . $slice . "\n";
            $right = findNum($slice, $strArr);
            if ($right != "") {
                // echo $arr[$i] . " => " . $right . "\n";
                $rightArr[$i] = $right;
                break;
            }
            $k--;
        }
        // echo "Right: " . $right . "\n";
    }
    for ($m = 0; $m < count($leftArr); $m++) {
        $val = $leftArr[$m] . $rightArr[$m];
        $arrNum[$m] = (int)$val;
    }
    return $arrNum;
}

$arrPartTwo = arrayOfIntPartTwo($arrStr, $numStr);
// print_r($arrPartTwo);
$resultPartTwo = calculateSum($arrPartTwo);
echo "Result of part two: " . $resultPartTwo . "\n";
?>
