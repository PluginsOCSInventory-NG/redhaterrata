<?php
/**
 * The following functions are used by the extension engine to generate a new table
 * for the plugin / destroy it on removal.
 */


/**
 * This function is called on installation and is used to 
 * create database schema for the plugin
 */
function extension_install_redhaterrata() {
    $commonObject = new ExtensionCommon;
    $commonObject -> sqlQuery("DROP TABLE IF EXISTS `redhaterrata`");
    $commonObject -> sqlQuery(
        "CREATE TABLE IF NOT EXISTS `redhaterrata` (
        `ID` INT(11) NOT NULL AUTO_INCREMENT,
        `HARDWARE_ID` INT(11) NOT NULL,
        `ERRATA` VARCHAR(255) NOT NULL,
        `PACKAGE` VARCHAR(255) DEFAULT NULL,
        `SEVERITY` VARCHAR(255) DEFAULT NULL,
        `TYPE` VARCHAR(255) DEFAULT NULL,
        `UPDATED` VARCHAR(255) DEFAULT NULL,
        PRIMARY KEY (ID, HARDWARE_ID)) ENGINE=INNODB;"
    );
}

/**
 * This function is called on removal and is used to 
 * destroy database schema for the plugin
 */
function extension_delete_redhaterrata()
{
    $commonObject = new ExtensionCommon;
    $commonObject -> sqlQuery("DROP TABLE IF EXISTS `redhaterrata`");
}

/**
 * This function is called on plugin upgrade
 */
function extension_upgrade_redhaterrata()
{

}

?>