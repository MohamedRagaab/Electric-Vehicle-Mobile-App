<?php

/* Control Motor From Mobile */
if(isset($_GET['on_off'])){

    /* Open File that store Motor status */
    $motorStatus = fopen('on_off.txt','w');
    // check the param is not embty
    if($_GET['on_off'] == 1){

        fwrite($motorStatus,'1');
        $statuson = 1;
        $motorJasonObjest = '{"on_off":'.$statuson.'}';
        echo($motorJasonObjest);

    }else if ($_GET['on_off'] == 0){

        fwrite($motorStatus,'0');
        $statusoff = 0;
        $motorJasonObjest = '{"on_off":'.$statusoff.'}';
        echo($motorJasonObjest);
        
    }

    /* Monitoring Temperature */
}else if(isset($_GET['getTemp'])){

    // if the mobile request
    if($_GET['getTemp'] == 5000){
    /* Open File that store Temperature status */
    $handletemp = fopen('temp.txt','r');
    // '{"temp":30}'
    $temperature = fread($handletemp,filesize('temp.txt'));
    $tempJasonObjest = '{"temp":'.$temperature.'}';
    echo($tempJasonObjest);

    // if the ESP request
    }else {

        $tempFile = fopen('temp.txt','w');
        fwrite($tempFile,$_GET['getTemp']);
        echo ("Temp is set");

    }


    /* Monitoring Speed */
}else if (isset($_GET['getSpeed'])){
    if (($_GET['getSpeed'] == 5000) && ($_GET['client'] == 'flutter')){
        /* Open File  */
        $handlespeed = fopen('actual_speed.txt','r');
        // '{"speed":100}'
        $speed = fread($handlespeed,filesize('actual_speed.txt'));
        $speedJasonObjest = '{"speed":'.$speed.'}';
        echo($speedJasonObjest);
        
    }else if ($_GET['client'] == 'esp'){

        $speedFile = fopen('actual_speed.txt','w');
        fwrite($speedFile,$_GET['getSpeed']);
        echo("Speed is set");

    /* Control Speed From Mobile */
    }else if (($_GET['client'] == 'flutter') && ($_GET['mode'] == 'control')){

        $speedFile = fopen('set_point.txt','w');
        fwrite($speedFile,$_GET['getSpeed']);
        echo("Speed is set");

    }
    


}


?>

