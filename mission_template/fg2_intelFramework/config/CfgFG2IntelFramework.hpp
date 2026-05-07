/*

    CfgFG2IntelFramework.hpp

    Defines the configuration for the Intel Framework system, including devices and jobs. You can customize the available devices, their associated jobs, 
    and the parameters for each job such as duration and total units. This configuration allows for a flexible and scalable Intel Framework system that 
    can be easily expanded with new devices and jobs as needed.

    DO NOT CHANGE THE CLASS NAMES OR STRUCTURE UNLESS YOU KNOW WHAT YOU ARE DOING, AS THIS MAY CAUSE ISSUES WITH THE SYSTEM. INSTEAD, ADD NEW DEVICES AND JOBS BY FOLLOWING THE EXISTING PATTERN.

*/

class CfgFG2IntelFramework
{
    class Devices
    {
        class SHREDDER
        {
            displayName = "Document Shredder";
            availableJobs[] = {"DOCUMENT_SHRED"};
            maxQueueSize = 200;
        };

        class HACK_TERMINAL
        {
            displayName = "Hack Terminal";
            availableJobs[] = {"DATABASE_HACK", "DATA_EXFILTRATE", "NETWORK_TRACE"};
            maxQueueSize = 10;
        };

        class SIGNAL_DECODER
        {
            displayName = "Signal Decoder";
            availableJobs[] = {"SIGNAL_DECRYPT"};
            maxQueueSize = 25;
        };

        class FORENSICS_STATION
        {
            displayName = "Forensics Station";
            availableJobs[] = {"FORENSIC_RECOVERY", "INTEL_ANALYZE"};
            maxQueueSize = 15;
        };

        class SECURITY_CONSOLE
        {
            displayName = "Security Console";
            availableJobs[] = {"ACCESS_OVERRIDE", "CAMERA_FEED_HACK"};
            maxQueueSize = 20;
        };

        class DATA_TERMINAL
        {
            displayName = "Data Terminal";
            availableJobs[] = {"DRIVE_WIPE", "ENCRYPT_FILES"};
            maxQueueSize = 30;
        };

        class SATELLITE_TERMINAL
        {
            displayName = "Satellite Terminal";
            availableJobs[] = {"SATELLITE_UPLINK"};
            maxQueueSize = 5;
        };

        class BIOMETRIC_SCANNER
        {
            displayName = "Biometric Scanner";
            availableJobs[] = {"BIOMETRIC_SCAN"};
            maxQueueSize = 10;
        };

        class VEHICLE_BLACKBOX
        {
            displayName = "Blackbox Reader";
            availableJobs[] = {"BLACKBOX_DOWNLOAD"};
            maxQueueSize = 5;
        };
    };

    class Jobs
    {
        class DOCUMENT_SHRED
        {
            displayName = "Dokumente schreddern";
            activeTitle = "SHREDDING DOCUMENTS";
            unitLabel = "Documents completed";
            duration = 15;
            durationVariance = 15;
            unitsTotal = 151;
        };

        class DATABASE_HACK
        {
            displayName = "Datenbank hacken";
            activeTitle = "HACKING DATABASE";
            unitLabel = "Databases breached";
            duration = 45;
            durationVariance = 20;
            unitsTotal = 1;
        };

        class SIGNAL_DECRYPT
        {
            displayName = "Signal entschlüsseln";
            activeTitle = "DECRYPTING SIGNAL";
            unitLabel = "Signals decoded";
            duration = 30;
            durationVariance = 10;
            unitsTotal = 3;
        };

        class DRIVE_WIPE
        {
            displayName = "Festplatte löschen";
            activeTitle = "WIPING DRIVE";
            unitLabel = "Drives wiped";
            duration = 20;
            durationVariance = 10;
            unitsTotal = 5;
        };

        class DATA_EXFILTRATE
        {
            displayName = "Daten extrahieren";
            activeTitle = "EXFILTRATING DATA";
            unitLabel = "Data packets extracted";
            duration = 25;
            durationVariance = 15;
            unitsTotal = 10;
        };

        class INTEL_ANALYZE
        {
            displayName = "Intel analysieren";
            activeTitle = "ANALYZING INTEL";
            unitLabel = "Files analyzed";
            duration = 35;
            durationVariance = 15;
            unitsTotal = 8;
        };

        class CAMERA_FEED_HACK
        {
            displayName = "Kameras hacken";
            activeTitle = "OVERRIDING CAMERA SYSTEM";
            unitLabel = "Cameras accessed";
            duration = 20;
            durationVariance = 10;
            unitsTotal = 4;
        };

        class SATELLITE_UPLINK
        {
            displayName = "Satellitenverbindung herstellen";
            activeTitle = "ESTABLISHING SATELLITE LINK";
            unitLabel = "Links established";
            duration = 60;
            durationVariance = 20;
            unitsTotal = 1;
        };

        class ENCRYPT_FILES
        {
            displayName = "Dateien verschlüsseln";
            activeTitle = "ENCRYPTING FILES";
            unitLabel = "Files encrypted";
            duration = 15;
            durationVariance = 5;
            unitsTotal = 12;
        };

        class BIOMETRIC_SCAN
        {
            displayName = "Biometrische Daten scannen";
            activeTitle = "SCANNING BIOMETRICS";
            unitLabel = "Profiles verified";
            duration = 10;
            durationVariance = 5;
            unitsTotal = 6;
        };

        class FORENSIC_RECOVERY
        {
            displayName = "Daten wiederherstellen";
            activeTitle = "RECOVERING DATA";
            unitLabel = "Files recovered";
            duration = 40;
            durationVariance = 20;
            unitsTotal = 6;
        };

        class ACCESS_OVERRIDE
        {
            displayName = "Zugriff überschreiben";
            activeTitle = "OVERRIDING ACCESS CONTROL";
            unitLabel = "Access points overridden";
            duration = 20;
            durationVariance = 10;
            unitsTotal = 3;
        };

        class NETWORK_TRACE
        {
            displayName = "Netzwerk verfolgen";
            activeTitle = "TRACING NETWORK";
            unitLabel = "Nodes traced";
            duration = 30;
            durationVariance = 15;
            unitsTotal = 5;
        };

        class BLACKBOX_DOWNLOAD
        {
            displayName = "Blackbox auslesen";
            activeTitle = "DOWNLOADING BLACKBOX DATA";
            unitLabel = "Logs extracted";
            duration = 25;
            durationVariance = 10;
            unitsTotal = 2;
        };
    };
};