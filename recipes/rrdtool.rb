
# TODO - Cursory glance suggests there is no existing rrdtool cookbook
# It might make sense to spit this out into a dedicated rrdtool cookbook

rrdtool_version = node['zenoss']['core4']['rrdtool']['version']
rrdtool_package = nil

if node['platform_family'] == "rhel"
  include_recipe "yum-repoforge"  

  case node['platform_version'].to_i
    when 6
      rrdtool_package = "#{rrdtool_version}-1.el6.rfx"
      rrdtool_repo = "rpmforge-extras"
    when 5
      rrdtool_package = "#{rrdtool_version}-1.el5.rf"
      rrdtool_repo = "rpmforge"
    else
      rrdtool_package = nil
  end
  
  yum_package "rrdtool" do
    version rrdtool_package
    # Disable EPEL to avoid the conflict listed in
    # http://jira.zenoss.com/jira/browse/ZEN-2547
    options "--disablerepo=epel"
    flush_cache [:before]
  end
  
end


