<?php

/**
 * fileRead function
 *
 * @param string $path - String value of path to modules
 *
 * @return string
 */
function fileRead($path): string
{
    $file = fopen($path, "r");
    if ($file != null) {
        $content = fread($file, filesize($path));
        fclose($file);
    }
    return $content;
}
