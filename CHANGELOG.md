# ComputeStacks Wordpress on OpenLiteSpeed Changelog

## 2023-June-27
* Added example multisite configurations for nginx

## 2023-June-15

* PHP 7.4 FPM with nginx.

## 2023-June-11

* PHP 8.0 & 8.2 FPM with nginx.

## 2023-June-10

* PHP 8.1 FPM with nginx added.

## 2023-May-15

* Added expire headers for css,js,images,fonts.

## 2023-May-5

* Ensure `mu-plugins` directory exists before installing our plugin.
* Tweak lsphp defaults.

***

## 2023-Apr-19

* Force WP-CRON to run via cronjobs, and disable per-request cron checks.
* Tweak default OLS PHP settings.
* Formatting change to log file configuration.

***

## 2023-Apr-13

* Auto-configure litespeed vhosts with latest configuration changes.
* Automatically install the ComputeStacks wordpress plugin to ensure functionality with older sites.

***

## 2023-Mar-10

* Added PHP 8.2 