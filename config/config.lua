SDC = {}

---------------------------------------------------------------------------------
-------------------------------Important Configs---------------------------------
---------------------------------------------------------------------------------
SDC.Framework = "qb-core" --Either "qb-core" or "esx"

SDC.DetectorCooldown = 2 --In Seconds (Wouldn't Touch This)
SDC.MaxSoundDistance = 20 --How close you have to be hear the sound
SDC.DetectorSoundFile = "detectorbeep" --Soundfile name
SDC.DetectorVolume = 1.0 --Volume of the sound
---------------------------------------------------------------------------------
-------------------------------Prop Configs--------------------------------------
---------------------------------------------------------------------------------
SDC.DetectorProps = { --Props that are identified as metal detectors
    --ex: "prop_name"
    "ch_prop_ch_metal_detector_01a"
}
SDC.SpawnDetectors = { --A Model Spawner to place down detectors that arn't native to the map
    --ex: {Coords = vec4(0.0, 0.0, 0.0, 0.0), Model = "prop_name"},
    {Coords = vec4(-365.7537, -244.4017, 36.0664, 235.3069), Model = "ch_prop_ch_metal_detector_01a"},
    {Coords = vec4(-364.8553, -243.2609, 36.0664, 235.3069), Model = "ch_prop_ch_metal_detector_01a"},
    {Coords = vec4(-364.0842, -242.1337, 36.0664, 235.3069), Model = "ch_prop_ch_metal_detector_01a"}
}
SDC.SpawnDetectorDist = 50 --How close/far you need to be for the prop to spawn/delete

---------------------------------------------------------------------------------
-------------------------------Item Configs--------------------------------------
---------------------------------------------------------------------------------
SDC.BlacklistedItems = { --Blacklisted items that will make the detector go off
    --ex: "item_name"
    "weapon_wrench"
}