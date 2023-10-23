<?php

require "../../modules/modules.php";

// $test = fileRead('../test.txt');
$test = fileRead('../input.txt');
$test = explode("\n", $test);
array_pop($test);

/**
 * howManyIncreases function
 *
 * @param array $arr - Array of measurements
 *
 * @return integer
 */
function howManyIncreases($arr): int
{
    $counter = 0;
    for ($i = 1; $i < count($arr); ++$i) {
        if ($arr[$i] > $arr[$i - 1]) {
            $counter++;
        }
    }
    return $counter;
}

$result = howManyIncreases($test);
echo "Result of part one: " . $result . "\n";

/**
 * tree_measurement function
 *
 * @param array $arr - Array of measurements
 *
 * @return array
 */
function tree_measurement($arr): array
{
    $result = array();
    for ($i = 2; $i < count($arr); ++$i) {
        $temp = $arr[$i] + $arr[$i - 1] + $arr[$i - 2];
        array_push($result, $temp);
    }
    return $result;
}

$partTwoArray = tree_measurement($test);
$partTwo = howManyIncreases($partTwoArray); 
echo "Result of part two: " . $partTwo . "\n";
