# aggregator-cookbook

 This chef cookbook configures an adsl aggregator.

## Supported Platforms

 ubuntu/debian

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['aggregator']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

## Usage

 depend on: chef-iproute2::default.rb

 Configurations aggregators are defined in a data bag "aggregators". Each aggregator is described in an item whose id(1) is its fqdn.

 (1): Dots are not allowed (only alphanumeric), substitute by underscores

eg:
 {
  "id": "aggregator_dev_gov_pf",
  "stop": [
    "ip route add default dev eth0;"
  ],
  "start": [
    "ip route add 192.168.0.0/16 via 192.168.8.2;",
    "ip route add default scope global",
    "nexthop via 192.168.8.3 weight 1",
    "nexthop via 192.168.8.4 weight 1",
    "nexthop via 192.168.8.5 weight 1"
  ]
}

 This recipe uses the chef-iproute2 cookbook which installs this ip configuration as a service...


### aggregator::default

Include `aggregator` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[aggregator::default]"
  ]
}
```

## License and Authors

Author:: PE, pf. (<philippe.eychart@mail.pf>)
