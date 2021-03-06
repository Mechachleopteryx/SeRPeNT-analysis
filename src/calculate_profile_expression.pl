# #################################################################################
# extract_common_profiles.pl
#
# Extract common profiles from diffproc benchmarking cell lines 
#
# amadis.pages@upf.edu
# amadis.pages@crg.eu
# #################################################################################

use strict;

# Usage:
#   perl extract_common_profiles.pl 

# Variable definition
my @cells = ("a549", "a549", "gm12878", "gm12878", "helas3", "helas3",
             "hepg2", "hepg2", "imr90", "imr90", "k562", "k562",
             "mcf7", "mcf7", "nhek", "nhek", "sknsh", "sknsh");
my @nread = (175033257, 141307675, 34303754, 53087115, 29674616, 29943178,
             38337423, 32112643, 207729440, 203347637, 37009953, 31479779,
             168359421, 158785959, 29326978, 35008048, 213226585, 91852402);
my @profs = (
  "chr1:565785-565837:-",
  "chr1:568627-568683:-",
  "chr11:65267559-65267651:+",
  "chr16:2205256-2205359:-",
  "chr20:34637273-34637331:-",
  "chr5:25189535-25189593:-",
  "chr5:96908083-96908140:+",
  "chr1:565293-565398:-",
  "chr1:568464-568570:-",
  "chr11:122026904-122026967:-",
  "chr11:65271384-65271446:+",
  "chr11:65272187-65272341:+",
  "chr14:52054198-52054261:-",
  "chr2:114647260-114647344:-",
  "chr5:104517386-104517445:-",
  "chr1:173836009-173836077:-",
  "chr1:173837076-173837127:-",
  "chr1:569388-569442:-",
  "chr1:569671-569755:-",
  "chr11:65212967-65213060:+",
  "chr15:93426059-93426110:+",
  "chr17:62223330-62223380:+",
  "chr17:62223588-62223651:+",
  "chr2:25451063-25451121:-",
  "chr20:26189010-26189095:-",
  "chr20:32580878-32580939:-",
  "chr3:177311463-177311513:+",
  "chr4:104291392-104291455:+",
  "chr8:128837246-128837341:+",
  "chr8:128916699-128916766:+",
  "chrX:22814912-22814963:-",
  "chr1:566849-566941:-",
  "chr1:567404-567458:-",
  "chr1:570181-570233:-",
  "chr11:65271218-65271270:+",
  "chr11:65272517-65272584:+",
  "chr2:213665648-213665697:+",
  "chr2:59830737-59830812:-"
);

my %params = map { $_ => 1 } @profs;

# Read mks/makefile.defs
for (my $i = 0; $i < scalar(@cells); $i++) {
  my $cell = $cells[$i];
  my $nrds = $nread[$i];
  my $reps = ($i % 2) + 1;
  my $file_in = "dat/$cell/short_r".$reps.".dat";
  my %profiles = ();

  open(EXP, " < $file_in");
  while(<EXP>) {
    chomp;
    my @a = split;
    $profiles{$a[4]} = $a[0];
  }
  close(EXP);

  foreach my $prf (keys %params) {
    my $number = 0;
    $number = $profiles{$prf} if (exists($profiles{$prf}));
    print $cell, "_$reps\t$prf\t", ($number / $nrds) * 1000000, "\n";
  }
  close(EXP);
}
