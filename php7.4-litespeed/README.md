# Wordpress with PHP 7.4 Open Litespeed

## Environmental Configuration Options

<table>
  <thead>
    <tr>
      <th>Name</th>
      <th>Value</th>
      <th>Default</th>
      <th>Notes</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>WORDPRESS_DB_HOST</td>
      <td>IP or Hostname of MySQL Database</td>
      <td><pre>null</pre></td>
      <td></td>
    </tr>
    <tr>
      <td>WORDPRESS_DB_NAME</td>
      <td>IP or Hostname of MySQL Database</td>
      <td><pre>null</pre></td>
      <td></td>
    </tr>
    <tr>
      <td>WORDPRESS_DB_USER</td>
      <td>IP or Hostname of MySQL Database</td>
      <td><pre>null</pre></td>
      <td></td>
    </tr>
    <tr>
      <td>WORDPRESS_DB_PASSWORD</td>
      <td>IP or Hostname of MySQL Database</td>
      <td><pre>null</pre></td>
      <td></td>
    </tr>
    <tr>
      <td>WORDPRESS_PLUGLIST</td>
      <td>comma separated list of plugins to install</td>
      <td><pre>litespeed-cache,wp-mail-smtp</pre></td>
      <td>only runs during initial installation</td>
    </tr>
    <tr>
      <td>WORDPRESS_TIMEZONE</td>
      <td>Timezone</td>
      <td><pre>UTC</pre></td>
      <td>only runs during initial installation</td>
    </tr>
    <tr>
      <td>WORDPRESS_LANGUAGE</td>
      <td>Language pack to install</td>
      <td><pre>en_US</pre></td>
      <td>only runs during initial installation</td>
    </tr>    
  </tbody>
</table>

## Monarx Support

The php7.4 variant of this image includes support for [Monarx](https://www.monarx.com). By default it's _**disabled**_ unless you include the following environmental variables at boot (_can be enabled after initial install_):

* `MONARX_ID`
* `MONARX_SECRET`
