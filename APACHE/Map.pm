# Plugin "RedHat Errata" OCSInventory

package Apache::Ocsinventory::Plugins::Redhaterrata::Map;
 
use strict;
 
use Apache::Ocsinventory::Map;
$DATA_MAP{redhaterrata} = {
   mask => 0,
   multi => 1,
   auto => 1,
   delOnReplace => 1,
   sortBy => 'ID',
   writeDiff => 0,
   cache => 0,
   fields => {
       ERRATA => {},
       PACKAGE => {},
       SEVERITY => {},
       TYPE => {},
       UPDATED => {}
   }
};
1;