# This state configures the timezone.

{%- set timezone = salt['pillar.get']('timezone:name', 'America/Chicago') %}
{%- set utc = salt['pillar.get']('timezone:utc', True) %}
{% from "timezone/map.jinja" import confmap with context %}

timezone_setting:
  timezone.system:
    - name: {{ timezone }}
    - utc: {{ utc }}

timezone_packages:
  pkg.installed:
    - name: {{ confmap.pkgname }}

timezone_symlink:
  file.symlink:
    - name: {{ confmap.path_localtime }}
    - target: {{ confmap.path_zoneinfo }}{{ timezone }}
    - require:
      - pkg: {{ confmap.pkgname }}
