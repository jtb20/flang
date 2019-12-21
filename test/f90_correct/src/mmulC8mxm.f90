!** Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
!** See https://llvm.org/LICENSE.txt for license information.
!** SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

!* Tests for runtime library MATMUL routines

program p
  
  parameter(NbrTests=1680)
  parameter(o_extent=2)
  parameter(n_extent=6)
  parameter(m_extent=4)
  parameter(k_extent=8)
  
  COMPLEX*8, dimension(n_extent,m_extent) :: arr1
  COMPLEX*8, dimension(m_extent,k_extent) :: arr2
  COMPLEX*8, dimension(n_extent,k_extent) :: arr3
  COMPLEX*8, dimension(n_extent,m_extent,o_extent) :: arr4
  COMPLEX*8, dimension(n_extent,o_extent,m_extent) :: arr5
  COMPLEX*8, dimension(o_extent,n_extent,m_extent) :: arr6
  
  COMPLEX*8, dimension(o_extent,m_extent,k_extent) :: arr7
  COMPLEX*8, dimension(m_extent,o_extent,k_extent) :: arr8
  COMPLEX*8, dimension(m_extent,k_extent,o_extent) :: arr9
  
  COMPLEX*8, dimension(n_extent,k_extent,o_extent) :: arr10
  COMPLEX*8, dimension(n_extent,o_extent,k_extent) :: arr11
  COMPLEX*8, dimension(o_extent,n_extent,k_extent) :: arr12
  
  COMPLEX*8, dimension(2:n_extent+1,2:m_extent+1) :: arr13
  COMPLEX*8, dimension(2:m_extent+1,2:k_extent+1) :: arr14
  COMPLEX*8, dimension(2:n_extent+1,2:k_extent+1) :: arr15
  COMPLEX*8, dimension(n_extent,k_extent) :: arr16
  
  COMPLEX*8 :: expect(NbrTests) 
  COMPLEX*8 :: results(NbrTests)
  
  integer:: i,j
  
  data arr1 /(0,4),(1,8),(2,11),(3,7),(4,4),(5,5),				&
             (6,4),(7,8),(8,11),(9,7),(10,2),(11,1),			&
             (12,2),(13,1),(14,4),(15,8),(16,11),(17,7),		&
             (18,2),(19,1),(20,4),(22,8),(22,11),(23,7)/
  data arr2 /(0,4),(1,8),(2,11),(3,7),(4,4),(5,5),				&
             (6,4),(7,8),(8,11),(9,7),(10,2),(11,1),			&
             (12,2),(13,1),(14,4),(15,8),(16,11),(17,7),		&
             (18,2),(19,1),(20,4),(21,8),(22,11),(23,7),		&
             (24,2),(25,1),(26,4),(27,8),(28,11),(29,7),               &
             (30,2),(31,1)/
  data arr3 /(0,4),(1,8),(2,11),(3,7),(4,4),(5,5),				&
             (6,4),(7,8),(8,11),(9,7),(10,2),(11,1), 			&
             (12,2),(13,1),(14,4),(15,8),(16,11),(17,7),		&
             (18,2),(19,1),(20,4),(21,8),(22,11),(23,7),		&
             (24,2),(25,1),(26,4),(27,8),(28,11),(29,7),		&
             (30,2),(31,1),(32,4),(33,8),(34,11),(35,7),		&
             (36,2),(37,1),(38,4),(39,8),(40,11),(41,7),		&
             (42,2),(43,1),(44,4),(45,8),(46,11),(47,7)/
  data arr4 /(0,4),(1,8),(2,11),(3,7),(4,4),(5,5),				&
             (6,4),(7,8),(8,11),(9,7),(10,2),(11,1), 			&
             (12,2),(13,1),(14,4),(15,8),(16,11),(17,7),		&
             (18,2),(19,1),(20,4),(21,8),(22,11),(23,7),		&
             (24,2),(25,1),(26,4),(27,8),(28,11),(29,7),		&
             (30,2),(31,1),(32,4),(33,8),(34,11),(35,7),		&
             (36,2),(37,1),(38,4),(39,8),(40,11),(41,7),		&
             (42,2),(43,1),(44,4),(45,8),(46,11),(47,7)/
  data arr5 /(0,4),(1,8),(2,11),(3,7),(4,4),(5,5),				&
             (6,4),(7,8),(8,11),(9,7),(10,2),(11,1), 			&
             (12,2),(13,1),(14,4),(15,8),(16,11),(17,7),		&
             (18,2),(19,1),(20,4),(21,8),(22,11),(23,7),		&
             (24,2),(25,1),(26,4),(27,8),(28,11),(29,7),		&
             (30,2),(31,1),(32,4),(33,8),(34,11),(35,7),		&
             (36,2),(37,1),(38,4),(39,8),(40,11),(41,7),		&
             (42,2),(43,1),(44,4),(45,8),(46,11),(47,7)/
  data arr6 /(0,4),(1,8),(2,11),(3,7),(4,4),(5,5),				&
             (6,4),(7,8),(8,11),(9,7),(10,2),(11,1), 			&
             (12,2),(13,1),(14,4),(15,8),(16,11),(17,7),		&
             (18,2),(19,1),(20,4),(21,8),(22,11),(23,7),		&
             (24,2),(25,1),(26,4),(27,8),(28,11),(29,7),		&
             (30,2),(31,1),(32,4),(33,8),(34,11),(35,7),		&
             (36,2),(37,1),(38,4),(39,8),(40,11),(41,7),		&
             (42,2),(43,1),(44,4),(45,8),(46,11),(47,7)/
  data arr7 /(0,4),(1,8),(2,11),(3,7),(4,4),(5,5),				&
             (6,4),(7,8),(8,11),(9,7),(10,2),(11,1), 			&
             (12,2),(13,1),(14,4),(15,8),(16,11),(17,7),		&
             (18,2),(19,1),(20,4),(21,8),(22,11),(23,7),		&
             (24,2),(25,1),(26,4),(27,8),(28,11),(29,7),		&
             (30,2),(31,1),(32,4),(33,8),(34,11),(35,7),		&
             (36,2),(37,1),(38,4),(39,8),(40,11),(41,7),		&
             (42,2),(43,1),(44,4),(45,8),(46,11),(47,7),		&
             (48,2),(49,1),(50,4),(51,8),(52,11),(53,7),		&
             (54,2),(55,1),(56,4),(57,8),(58,11),(59,7),		&
             (60,2),(61,1),(62,4),(63,8)/
  data arr8 /(0,4),(1,8),(2,11),(3,7),(4,4),(5,5),				&
             (6,4),(7,8),(8,11),(9,7),(10,2),(11,1), 			&
             (12,2),(13,1),(14,4),(15,8),(16,11),(17,7),		&
             (18,2),(19,1),(20,4),(21,8),(22,11),(23,7),		&
             (24,2),(25,1),(26,4),(27,8),(28,11),(29,7),		&
             (30,2),(31,1),(32,4),(33,8),(34,11),(35,7),		&
             (36,2),(37,1),(38,4),(39,8),(40,11),(41,7),		&
             (42,2),(43,1),(44,4),(45,8),(46,11),(47,7),		&
             (48,2),(49,1),(50,4),(51,8),(52,11),(53,7),		&
             (54,2),(55,1),(56,4),(57,8),(58,11),(59,7),		&
             (60,2),(61,1),(62,4),(63,8)/
  data arr9 /(0,4),(1,8),(2,11),(3,7),(4,4),(5,5),				&
             (6,4),(7,8),(8,11),(9,7),(10,2),(11,1), 			&
             (12,2),(13,1),(14,4),(15,8),(16,11),(17,7),		&
             (18,2),(19,1),(20,4),(21,8),(22,11),(23,7),		&
             (24,2),(25,1),(26,4),(27,8),(28,11),(29,7),		&
             (30,2),(31,1),(32,4),(33,8),(34,11),(35,7),		&
             (36,2),(37,1),(38,4),(39,8),(40,11),(41,7),		&
             (42,2),(43,1),(44,4),(45,8),(46,11),(47,7),		&
             (48,2),(49,1),(50,4),(51,8),(52,11),(53,7),		&
             (54,2),(55,1),(56,4),(57,8),(58,11),(59,7),		&
             (60,2),(61,1),(62,4),(63,8)/
  data arr10 /(0,4),(1,8),(2,11),(3,7),(4,4),(5,5),				&
              (6,4),(7,8),(8,11),(9,7),(10,2),(11,1),	 		&
             (12,2),(13,1),(14,4),(15,8),(16,11),(17,7),		&
              (18,2),(19,1),(20,4),(21,8),(22,11),(23,7),		&
             (24,2),(25,1),(26,4),(27,8),(28,11),(29,7),		&
             (30,2),(31,1),(32,4),(33,8),(34,11),(35,7),		&
             (36,2),(37,1),(38,4),(39,8),(40,11),(41,7),		&
             (42,2),(43,1),(44,4),(45,8),(46,11),(47,7),		&
             (48,2),(49,1),(50,4),(51,8),(52,11),(53,7),		&
             (54,2),(55,1),(56,4),(57,8),(58,11),(59,7),		&
             (60,2),(61,1),(62,4),(63,8),(64,11),(65,7),		&
             (66,2),(67,1),(68,4),(69,8),(70,11),(71,7),		&
             (72,2),(73,1),(74,4),(75,8),(76,11),(77,7),		&
             (78,2),(79,1),(80,4),(81,8),(82,11),(83,7),		&
             (84,2),(85,1),(86,4),(87,8),(88,11),(89,7),		&
             (90,2),(91,1),(92,4),(93,8),(94,11),(95,7)/
  data arr11 /(0,4),(1,8),(2,11),(3,7),(4,4),(5,5),				&
             (6,4),(7,8),(8,11),(9,7),(10,2),(11,1),	 		&
             (12,2),(13,1),(14,4),(15,8),(16,11),(17,7),		&
             (18,2),(19,1),(20,4),(21,8),(22,11),(23,7),		&
             (24,2),(25,1),(26,4),(27,8),(28,11),(29,7),		&
             (30,2),(31,1),(32,4),(33,8),(34,11),(35,7),		&
             (36,2),(37,1),(38,4),(39,8),(40,11),(41,7),		&
             (42,2),(43,1),(44,4),(45,8),(46,11),(47,7),		&
             (48,2),(49,1),(50,4),(51,8),(52,11),(53,7),		&
             (54,2),(55,1),(56,4),(57,8),(58,11),(59,7),		&
             (60,2),(61,1),(62,4),(63,8),(64,11),(65,7),		&
             (66,2),(67,1),(68,4),(69,8),(70,11),(71,7),		&
             (72,2),(73,1),(74,4),(75,8),(76,11),(77,7),		&
             (78,2),(79,1),(80,4),(81,8),(82,11),(83,7),		&
             (84,2),(85,1),(86,4),(87,8),(88,11),(89,7),		&
             (90,2),(91,1),(92,4),(93,8),(94,11),(95,7)/
  data arr12 /(0,4),(1,8),(2,11),(3,7),(4,4),(5,5),				&
              (6,4),(7,8),(8,11),(9,7),(10,2),(11,1),	 		&
              (12,2),(13,1),(14,4),(15,8),(16,11),(17,7),		&
              (18,2),(19,1),(20,4),(21,8),(22,11),(23,7),		&
              (24,2),(25,1),(26,4),(27,8),(28,11),(29,7),		&
              (30,2),(31,1),(32,4),(33,8),(34,11),(35,7),		&
              (36,2),(37,1),(38,4),(39,8),(40,11),(41,7),		&
              (42,2),(43,1),(44,4),(45,8),(46,11),(47,7),		&
              (48,2),(49,1),(50,4),(51,8),(52,11),(53,7),		&
              (54,2),(55,1),(56,4),(57,8),(58,11),(59,7),		&
              (60,2),(61,1),(62,4),(63,8),(64,11),(65,7),		&
              (66,2),(67,1),(68,4),(69,8),(70,11),(71,7),		&
              (72,2),(73,1),(74,4),(75,8),(76,11),(77,7),		&
              (78,2),(79,1),(80,4),(81,8),(82,11),(83,7),		&
              (84,2),(85,1),(86,4),(87,8),(88,11),(89,7),		&
              (90,2),(91,1),(92,4),(93,8),(94,11),(95,7)/
  data arr13 /(0,4),(1,8),(2,11),(3,7),(4,4),(5,5),                     &
             (6,4),(7,8),(8,11),(9,7),(10,2),(11,1),                    &
             (12,2),(13,1),(14,4),(15,8),(16,11),(17,7),                &
             (18,2),(19,1),(20,4),(22,8),(22,11),(23,7)/
  data arr14 /(0,4),(1,8),(2,11),(3,7),(4,4),(5,5),                     &
             (6,4),(7,8),(8,11),(9,7),(10,2),(11,1),                    &
             (12,2),(13,1),(14,4),(15,8),(16,11),(17,7),                &
             (18,2),(19,1),(20,4),(21,8),(22,11),(23,7),                &
             (24,2),(25,1),(26,4),(27,8),(28,11),(29,7),                &
             (30,2),(31,1)/
  data arr15 /(0,4),(1,8),(2,11),(3,7),(4,4),(5,5),                     &
             (6,4),(7,8),(8,11),(9,7),(10,2),(11,1),                    &
             (12,2),(13,1),(14,4),(15,8),(16,11),(17,7),                &
             (18,2),(19,1),(20,4),(21,8),(22,11),(23,7),                &
             (24,2),(25,1),(26,4),(27,8),(28,11),(29,7),                &
             (30,2),(31,1),(32,4),(33,8),(34,11),(35,7),                &
             (36,2),(37,1),(38,4),(39,8),(40,11),(41,7),                &
             (42,2),(43,1),(44,4),(45,8),(46,11),(47,7)/
  
  data expect /  &
  !test 1,96
   (0.0,320.0), (-24.0,349.0), (-108.0,397.0), &
   (-123.0,450.0), (-122.0,483.0), (-40.0,492.0), &
   (168.0,284.0), (166.0,328.0), (125.0,415.0), (142.0,460.0), &
   (158.0,475.0), (229.0,443.0), (294.0,194.0), (263.0,262.0), &
   (238.0,397.0), (347.0,435.0), (433.0,449.0), (479.0,385.0), &
   (480.0,356.0), (534.0,442.0), (543.0,619.0), (576.0,658.0), &
   (590.0,651.0), (691.0,549.0), (582.0,290.0), (583.0,406.0), &
   (590.0,637.0), (739.0,675.0), (849.0,673.0), (927.0,545.0), &
   (720.0,560.0), (776.0,709.0), (772.0,997.0), (857.0,1050.0), &
   (918.0,1043.0), (1080.0,892.0), (912.0,500.0), (1014.0,658.0), &
   (1071.0,979.0), (1164.0,1018.0), (1214.0,987.0), (1363.0,789.0), &
   (1014.0,434.0), (1063.0,622.0), (1118.0,997.0), (1327.0,1035.0), &
   (1473.0,1009.0), (1599.0,785.0), &
  !test 97,192
   (0.0,0.0), (-24.0,349.0), (-108.0,397.0), &
   (-123.0,450.0), (-122.0,483.0), (-40.0,492.0), &
   (0.0,0.0), (166.0,328.0), (125.0,415.0), (142.0,460.0), &
   (158.0,475.0), (229.0,443.0), (0.0,0.0), (263.0,262.0), &
   (238.0,397.0), (347.0,435.0), (433.0,449.0), (479.0,385.0), &
   (0.0,0.0), (534.0,442.0), (543.0,619.0), (576.0,658.0), &
   (590.0,651.0), (691.0,549.0), (0.0,0.0), (583.0,406.0), &
   (590.0,637.0), (739.0,675.0), (849.0,673.0), (927.0,545.0), &
   (0.0,0.0), (776.0,709.0), (772.0,997.0), (857.0,1050.0), &
   (918.0,1043.0), (1080.0,892.0), (0.0,0.0), (1014.0,658.0), &
   (1071.0,979.0), (1164.0,1018.0), (1214.0,987.0), (1363.0,789.0), &
   (0.0,0.0), (1063.0,622.0), (1118.0,997.0), (1327.0,1035.0), &
   (1473.0,1009.0), (1599.0,785.0), &
  !test 193,288
   (0.0,320.0), (-24.0,349.0), (-108.0,397.0), &
   (-123.0,450.0), (-122.0,483.0), (0.0,0.0), (168.0,284.0), &
    (166.0,328.0), (125.0,415.0), (142.0,460.0), (158.0,475.0), &
    (0.0,0.0), (294.0,194.0), (263.0,262.0), (238.0,397.0), &
    (347.0,435.0), (433.0,449.0), (0.0,0.0), (480.0,356.0), &
    (534.0,442.0), (543.0,619.0), (576.0,658.0), (590.0,651.0), &
    (0.0,0.0), (582.0,290.0), (583.0,406.0), (590.0,637.0), &
    (739.0,675.0), (849.0,673.0), (0.0,0.0), (720.0,560.0), &
    (776.0,709.0), (772.0,997.0), (857.0,1050.0), (918.0,1043.0), &
    (0.0,0.0), (912.0,500.0), (1014.0,658.0), (1071.0,979.0), &
    (1164.0,1018.0), (1214.0,987.0), (0.0,0.0), (1014.0,434.0), &
    (1063.0,622.0), (1118.0,997.0), (1327.0,1035.0), (1473.0,1009.0), &
    (0.0,0.0), &
  !test 289,384
   (16.0,320.0), (8.0,345.0), (-64.0,389.0), (-95.0,438.0), &
    (-106.0,467.0), (-20.0,472.0), (184.0,268.0), &
   (194.0,292.0), (161.0,363.0), (158.0,420.0), (158.0,443.0), &
   (229.0,403.0), (338.0,162.0), (343.0,187.0), (343.0,287.0), &
   (400.0,346.0), (445.0,373.0), (494.0,290.0), (488.0,308.0), &
   (538.0,344.0), (541.0,483.0), (554.0,568.0), (550.0,595.0), &
   (641.0,479.0), (626.0,226.0), (655.0,267.0), (679.0,439.0), &
   (768.0,530.0), (829.0,565.0), (902.0,410.0), (736.0,480.0), &
   (788.0,545.0), (776.0,769.0), (825.0,898.0), (854.0,947.0), &
   (1000.0,772.0), (920.0,404.0), (1006.0,464.0), (1045.0,711.0), &
   (1106.0,844.0), (1126.0,883.0), (1253.0,659.0), (1058.0,322.0), &
   (1123.0,387.0), (1183.0,667.0), (1320.0,806.0), (1405.0,853.0), &
   (1514.0,590.0), &
  !test 193,240
   (16.0,320.0), (8.0,345.0), (-64.0,389.0), (-95.0,438.0), &
    (-106.0,467.0), (-20.0,472.0), (184.0,268.0), &
   (194.0,292.0), (161.0,363.0), (158.0,420.0), (158.0,443.0), &
   (229.0,403.0), (338.0,162.0), (343.0,187.0), (343.0,287.0), &
   (400.0,346.0), (445.0,373.0), (494.0,290.0), (488.0,308.0), &
   (538.0,344.0), (541.0,483.0), (554.0,568.0), (550.0,595.0), &
   (641.0,479.0), (626.0,226.0), (655.0,267.0), (679.0,439.0), &
   (768.0,530.0), (829.0,565.0), (902.0,410.0), (736.0,480.0), &
   (788.0,545.0), (776.0,769.0), (825.0,898.0), (854.0,947.0), &
   (1000.0,772.0), (920.0,404.0), (1006.0,464.0), (1045.0,711.0), &
   (1106.0,844.0), (1126.0,883.0), (1253.0,659.0), (1058.0,322.0), &
   (1123.0,387.0), (1183.0,667.0), (1320.0,806.0), (1405.0,853.0), &
   (1514.0,590.0), &
  !test 481,576
   (-40.0,188.0), (-74.0,213.0), (-140.0,245.0), &
   (-133.0,272.0), (-111.0,296.0), (-60.0,310.0), &
   (58.0,126.0), (41.0,169.0), (17.0,227.0), (52.0,228.0), &
   (92.0,222.0), (124.0,210.0), (98.0,154.0), (55.0,232.0), &
   (22.0,333.0), (113.0,325.0), (202.0,306.0), (233.0,285.0), &
   (226.0,182.0), (257.0,275.0), (275.0,399.0), (310.0,362.0), &
   (348.0,310.0), (402.0,260.0), (242.0,234.0), (223.0,368.0), &
   (214.0,541.0), (329.0,501.0), (442.0,442.0), (497.0,389.0), &
   (320.0,388.0), (346.0,553.0), (340.0,765.0), (407.0,712.0), &
   (489.0,636.0), (600.0,570.0), (442.0,302.0), (509.0,479.0), &
   (563.0,711.0), (634.0,626.0), (708.0,514.0), (798.0,416.0), &
   (458.0,354.0), (475.0,572.0), (502.0,853.0), (653.0,765.0), &
   (802.0,646.0), (893.0,545.0), &
  !test 577,672
   (-40.0,188.0), (-74.0,213.0), (-140.0,245.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (58.0,126.0), &
   (41.0,169.0), (17.0,227.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (98.0,154.0), (55.0,232.0), (22.0,333.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), &
  !test 673,768
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (194.0,292.0), &
   (161.0,363.0), (158.0,420.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (343.0,187.0), (343.0,287.0), (400.0,346.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (538.0,344.0), &
   (541.0,483.0), (554.0,568.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
  !test 767,864
   (-40.0,188.0), (-74.0,213.0), (-140.0,245.0), &
   (-133.0,272.0), (-111.0,296.0), (-60.0,310.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (98.0,154.0), (55.0,232.0), &
   (22.0,333.0), (113.0,325.0), (202.0,306.0), (233.0,285.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (242.0,234.0), (223.0,368.0), &
   (214.0,541.0), (329.0,501.0), (442.0,442.0), (497.0,389.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (442.0,302.0), (509.0,479.0), &
   (563.0,711.0), (634.0,626.0), (708.0,514.0), (798.0,416.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), &
  !test 433,480
   (-6.0,324.0), (0.0,0.0), (-66.0,376.0), (0.0,0.0), &
    (-157.0,443.0), (0.0,0.0), (158.0,194.0), &
   (0.0,0.0), (142.0,270.0), (0.0,0.0), (145.0,337.0), &
   (0.0,0.0), (274.0,256.0), (0.0,0.0), (233.0,390.0), &
   (0.0,0.0), (323.0,491.0), (0.0,0.0), (462.0,198.0), &
   (0.0,0.0), (516.0,350.0), (0.0,0.0), (577.0,445.0), &
   (0.0,0.0), (562.0,320.0), (0.0,0.0), (569.0,542.0), &
   (0.0,0.0), (707.0,683.0), (0.0,0.0), (714.0,484.0), &
   (0.0,0.0), (774.0,756.0), (0.0,0.0), (803.0,923.0), &
   (0.0,0.0), (894.0,294.0), (0.0,0.0), (1020.0,578.0), &
   (0.0,0.0), (1153.0,733.0), (0.0,0.0), (994.0,416.0), &
   (0.0,0.0), (1073.0,770.0), (0.0,0.0), (1283.0,971.0), &
   (0.0,0.0), &
  !test 961,1056
   (-40.0,188.0), (0.0,0.0), (-140.0,245.0), (0.0,0.0), &
    (-111.0,296.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (98.0,154.0), (0.0,0.0), (22.0,333.0), &
   (0.0,0.0), (202.0,306.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (242.0,234.0), (0.0,0.0), (214.0,541.0), &
   (0.0,0.0), (442.0,442.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (442.0,302.0), (0.0,0.0), (563.0,711.0), &
   (0.0,0.0), (708.0,514.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), &
  !test 529,1152
   (-6.0,324.0), (0.0,0.0), (-66.0,376.0), (0.0,0.0), &
    (-157.0,443.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (274.0,256.0), (0.0,0.0), (233.0,390.0), &
   (0.0,0.0), (323.0,491.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (562.0,320.0), (0.0,0.0), (569.0,542.0), &
   (0.0,0.0), (707.0,683.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (894.0,294.0), (0.0,0.0), (1020.0,578.0), &
   (0.0,0.0), (1153.0,733.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), &
  !test 1153,1248
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (58.0,232.0), &
   (0.0,0.0), (47.0,304.0), (0.0,0.0), (125.0,285.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (258.0,364.0), &
   (0.0,0.0), (291.0,468.0), (0.0,0.0), (409.0,369.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (315.0,543.0), &
   (0.0,0.0), (417.0,713.0), (0.0,0.0), (638.0,568.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (569.0,537.0), &
   (0.0,0.0), (751.0,715.0), (0.0,0.0), (958.0,466.0), &
  !test 1249,1344
   (0.0,0.0), (475.0,572.0), (0.0,0.0), (653.0,765.0), &
   (0.0,0.0), (893.0,545.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (346.0,553.0), (0.0,0.0), (407.0,712.0), &
   (0.0,0.0), (600.0,570.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (257.0,275.0), (0.0,0.0), (310.0,362.0), &
   (0.0,0.0), (402.0,260.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (41.0,169.0), (0.0,0.0), (52.0,228.0), &
   (0.0,0.0), (124.0,210.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
  !test 1345,1440
   (894.0,294.0), (0.0,0.0), (1020.0,578.0), (0.0,0.0), &
   (1153.0,733.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (562.0,320.0), (0.0,0.0), (569.0,542.0), (0.0,0.0), &
   (707.0,683.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (274.0,256.0), (0.0,0.0), (233.0,390.0), (0.0,0.0), &
   (323.0,491.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (-6.0,324.0), (0.0,0.0), (-66.0,376.0), (0.0,0.0), &
    (-157.0,443.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), &
  !test 1441,1536
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (58.0,232.0), &
   (0.0,0.0), (47.0,304.0), (0.0,0.0), (125.0,285.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (258.0,364.0), &
   (0.0,0.0), (291.0,468.0), (0.0,0.0), (409.0,369.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (315.0,543.0), &
   (0.0,0.0), (417.0,713.0), (0.0,0.0), (638.0,568.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (569.0,537.0), &
   (0.0,0.0), (751.0,715.0), (0.0,0.0), (958.0,466.0), &
  !test 1537,1728
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (470.0,222.0), &
   (482.0,338.0), (502.0,410.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (773.0,461.0), (782.0,658.0), (790.0,771.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (1071.0,475.0), &
   (1104.0,744.0), (1152.0,889.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
  !test 1729,1920
   (56.0,738.0), (82.0,758.0), (16.0,790.0), (-73.0,825.0), &
   (-139.0,857.0), (-44.0,868.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (1502.0,648.0), (1573.0,617.0), (1564.0,790.0), &
   (1535.0,1014.0), (1526.0,1187.0), (1657.0,1003.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (2936.0,930.0), (3058.0,854.0), (3088.0,1174.0), &
   (3095.0,1593.0), (3125.0,1913.0), (3316.0,1540.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (4408.0,516.0), (4562.0,376.0), (4688.0,824.0), &
   (4807.0,1419.0), (4933.0,1867.0), (5108.0,1286.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), &
  !test 1921,2112
   (0.0,0.0), (3530.0,1068.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (3682.0,1312.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (3719.0,2051.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (3994.0,486.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (4202.0,722.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (4375.0,1513.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (4400.0,912.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (4606.0,1198.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (4712.0,2099.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (4826.0,1140.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (5050.0,1456.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (5159.0,2447.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (5290.0,558.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (5570.0,866.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (5815.0,1909.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (5696.0,984.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (5974.0,1342.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (6152.0,2495.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (6122.0,1212.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (6418.0,1600.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (6599.0,2843.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (6586.0,630.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (6938.0,1010.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (7255.0,2305.0), (0.0,0.0), (0.0,0.0), &
  !test 2113,2304
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (260.0,272.0), (0.0,0.0), (244.0,348.0), (0.0,0.0), &
   (247.0,415.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (1104.0,664.0), (0.0,0.0), (1164.0,936.0), (0.0,0.0), &
   (1193.0,1103.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (2004.0,444.0), (0.0,0.0), (2202.0,860.0), (0.0,0.0), &
   (2407.0,1075.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (2824.0,674.0), (0.0,0.0), (3047.0,1292.0), (0.0,0.0), &
   (3401.0,1613.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
  !test 2305,2456
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (50.0,642.0), (0.0,0.0), &
   (10.0,694.0), (0.0,0.0), (-145.0,761.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (632.0,426.0), (0.0,0.0), &
   (646.0,520.0), (0.0,0.0), (560.0,749.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (1208.0,474.0), (0.0,0.0), &
   (1270.0,616.0), (0.0,0.0), (1232.0,1013.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (1810.0,342.0), (0.0,0.0), &
   (1946.0,506.0), (0.0,0.0), (2047.0,1045.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
  !test 2467,2688
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (772.0,390.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (788.0,595.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (881.0,521.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (1629.0,496.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (1755.0,921.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (1985.0,731.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (2590.0,812.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (2756.0,1445.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (3047.0,1127.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (3460.0,912.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (3770.0,1753.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (4187.0,1307.0), (0.0,0.0), &
  !test 2689,2880
   (0.0,0.0), (2715.0,1533.0), (0.0,0.0), (3480.0,760.0), &
   (0.0,0.0), (4196.0,1106.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (2260.0,1412.0), (0.0,0.0), (2948.0,795.0), &
   (0.0,0.0), (3607.0,1153.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (1869.0,1465.0), (0.0,0.0), (2538.0,964.0), &
   (0.0,0.0), (2992.0,1294.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (1635.0,981.0), (0.0,0.0), (2112.0,520.0), &
   (0.0,0.0), (2540.0,746.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
  !test 2881,3072
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (3688.0,762.0), (0.0,0.0), &
   (4156.0,2203.0), (0.0,0.0), (4880.0,1196.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (2536.0,510.0), (0.0,0.0), &
   (2812.0,1519.0), (0.0,0.0), (3344.0,848.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (1384.0,510.0), (0.0,0.0), &
   (1468.0,1087.0), (0.0,0.0), (1808.0,752.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (224.0,462.0), (0.0,0.0), &
   (80.0,623.0), (0.0,0.0), (256.0,640.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
  !test 3073,3264
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (401.0,309.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (535.0,211.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (686.0,314.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (1091.0,878.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (1486.0,584.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (1733.0,779.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (1841.0,1045.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (2359.0,531.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (2894.0,794.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (0.0,0.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (2434.0,1713.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (3248.0,1055.0), &
   (0.0,0.0), (0.0,0.0), (0.0,0.0), (3892.0,1462.0), &
  !test 1633,1680
   (0.0,320.0), (-24.0,349.0), (-108.0,397.0), &
   (-123.0,450.0), (-122.0,483.0), (-40.0,492.0), &
   (168.0,284.0), (166.0,328.0), (125.0,415.0), (142.0,460.0), &
   (158.0,475.0), (229.0,443.0), (294.0,194.0), (263.0,262.0), &
   (238.0,397.0), (347.0,435.0), (433.0,449.0), (479.0,385.0), &
   (480.0,356.0), (534.0,442.0), (543.0,619.0), (576.0,658.0), &
   (590.0,651.0), (691.0,549.0), (582.0,290.0), (583.0,406.0), &
   (590.0,637.0), (739.0,675.0), (849.0,673.0), (927.0,545.0), &
   (720.0,560.0), (776.0,709.0), (772.0,997.0), (857.0,1050.0), &
   (918.0,1043.0), (1080.0,892.0), (912.0,500.0), (1014.0,658.0), &
   (1071.0,979.0), (1164.0,1018.0), (1214.0,987.0), (1363.0,789.0), &
   (1014.0,434.0), (1063.0,622.0), (1118.0,997.0), (1327.0,1035.0), &
   (1473.0,1009.0), (1599.0,785.0)/
  
  !test 1-96
  arr3=0
  arr3 = matmul(arr1,arr2)
  call assign_result(1,48,arr3,results)
  !print *,"test 1,96"
  !print *,arr3
  
  ! test 97-192
  arr3=0
  arr3(2:n_extent,:) = matmul(arr1(2:n_extent,:),arr2)
  call assign_result(49,96,arr3,results)
  !print *,"test 97,192"
  !print *,arr3
  
  ! test 193-288
  arr3=0
  arr3(1:n_extent-1,:) = matmul(arr1(1:n_extent-1,:),arr2)
  call assign_result(97,144,arr3,results)
  !print *,"test 193,288"
  !print *,arr3
  
  ! test 289-384
  arr3=0
  arr3 = matmul(arr1(:,2:m_extent),arr2(2:m_extent,:))
  call assign_result(145,192,arr3,results)
  !print *,"test 289,384"
  !print *,arr3
  
  ! test 385-480
  arr3=0
  arr3 = matmul(arr1(:,2:m_extent),arr2(2:m_extent,:))
  call assign_result(193,240,arr3,results)
  !print *,"test 193,240"
  !print *,arr3
  
  ! test 481-576
  arr3=0
  arr3 = matmul(arr1(:,1:m_extent-1),arr2(1:m_extent-1,:))
  call assign_result(241,288,arr3,results)
  !print *,"test 481,576"
  !print *,arr3
  
  !test 577-672
  arr3=0
  arr3(1:3,1:3) = matmul(arr1(1:3,1:3),arr2(1:3,1:3))
  call assign_result(289,336,arr3,results)
  !print *,"test 577,672"
  !print *,arr3
  
  ! test 673-768
  arr3=0
  arr3(2:4,2:4) = matmul(arr1(2:4,2:4),arr2(2:4,2:4))
  call assign_result(337,384,arr3,results)
  !print *,"test 673,768"
  !print *,arr3
  
  ! test 767-864
  arr3=0
  arr3(:,1:k_extent:2) = matmul(arr1(:,1:m_extent-1),arr2(1:m_extent-1,1:k_extent:2))
  call assign_result(385,432,arr3,results)
  !print *,"test 767,864"
  !print *,arr3
  
  ! test 865-960
  arr3=0
  arr3(1:n_extent:2,:) = matmul(arr1(1:n_extent:2,2:m_extent),arr2(1:m_extent-1,:))
  call assign_result(433,480,arr3,results)
  !print *,"test 433,480"
  !print *,arr3
  
  ! test 961-1056
  arr3=0
  arr3(1:n_extent:2,1:k_extent:2) = matmul(arr1(1:n_extent:2,1:m_extent-1),      &
                                           arr2(1:m_extent-1,1:k_extent:2))
  call assign_result(481,528,arr3,results)
  !print *,"test 961,1056"
  !print *,arr3
  
  ! test 1057-1152
  arr3=0
  arr3(1:n_extent-1:2,1:k_extent-1:2) = matmul(arr1(1:n_extent-1:2,2:m_extent),	&
                                               arr2(1:m_extent-1,1:k_extent:2))
  call assign_result(529,576,arr3,results)
  !print *,"test 529,1152"
  !print *,arr3
  
  ! test 1153-1248
  arr3=0
  arr3(2:n_extent:2,2:k_extent:2) = matmul(arr1(2:n_extent:2,1:m_extent-1),	&
                                               arr2(2:m_extent,2:k_extent:2))
  call assign_result(577,624,arr3,results)
  !print *,"test 1153,1248"
  !print *,arr3
  
  !test 1249-1344
  arr3=0
  arr3(n_extent:1:-2,1:k_extent:2) = matmul(arr1(n_extent:1:-2,1:m_extent-1),      &
                                           arr2(1:m_extent-1,k_extent:1:-2))
  call assign_result(625,672,arr3,results)
  !print *,"test 1249,1344"
  !print *,arr3
  
  ! test 1345-1440
  arr3=0
  arr3(1:n_extent-1:2,k_extent-1:1:-2) = matmul(arr1(1:n_extent-1:2,m_extent:2:-1),	&
                                               arr2(m_extent-1:1:-1,1:k_extent:2))
  call assign_result(673,720,arr3,results)
  !print *,"test 1345,1440"
  !print *,arr3
  
  ! test 1441-1536
  arr3=0
  arr3(n_extent:2:-2,k_extent:2:-2) = matmul(arr1(n_extent:2:-2,m_extent-1:1:-1),	&
                                               arr2(m_extent:2:-1,k_extent:2:-2))
  call assign_result(721,768,arr3,results)
  !print *,"test 1441,1536"
  !print *,arr3
  
  ! test 1537-1728
  arr10=0
  arr10(2:4,2:4:1) = matmul(arr4(2:4,2:4,1),arr7(1,2:4,2:4))
  call assign_result(769,864,arr10,results)
  !print *,"test 1537,1728"
  !print *,arr10
  
  ! test 1729-1920
  arr11=0
  arr11(:,1,1:k_extent:2) = matmul(arr4(:,1:m_extent-1,2),arr8(1:m_extent-1,1,1:k_extent:2))
  call assign_result(865,960,arr11,results)
  !print *,"test 1729,1920"
  !print *,arr11
  
  !test 1921-2112
  arr12=0
  arr12(2,1:n_extent:2,:) = matmul(arr4(1:n_extent:2,2:m_extent,2),arr9(1:m_extent-1,:,2))
  call assign_result(961,1056,arr12,results)
  !print *,"test 1921,2112"
  !print *,arr12
  
  ! test 2113-2304
  arr10=0
  arr10(1:n_extent:2,1:k_extent:2,2) = matmul(arr5(1:n_extent:2,2,1:m_extent-1),      &
                                           arr8(1:m_extent-1,2,1:k_extent:2))
  call assign_result(1057,1152,arr10,results)
  !print *,"test 2113,2304"
  !print *,arr10
  
  !test 2305-2456
  arr11=0
  arr11(1:n_extent-1:2,2,1:k_extent-1:2) = matmul(arr5(1:n_extent-1:2,1,2:m_extent),	&
                                               arr9(1:m_extent-1,1:k_extent:2,1))
  call assign_result(1153,1248,arr11,results)
  !print *,"test 2305,2456"
  !print *,arr11
  
  ! test 2457-2688
  arr12=0
  arr12(1,2:n_extent:2,2:k_extent:2) = matmul(arr5(2:n_extent:2,2,1:m_extent-1),	&
                                               arr7(2,2:m_extent,2:k_extent:2))
  call assign_result(1249,1344,arr12,results)
  !print *,"test 2467,2688"
  !print *,arr12
  
  !test 2689-2880
  arr10=0
  arr10(n_extent:1:-2,1:k_extent:2,1) = matmul(arr6(2,n_extent:1:-2,1:m_extent-1),      &
                                           arr9(1:m_extent-1,k_extent:1:-2,2))
  call assign_result(1345,1440,arr10,results)
  !print *,"test 2689,2880"
  !print *,arr10
  
  !test 2881-3072
  arr11=0
  arr11(1:n_extent-1:2,2,k_extent-1:1:-2) = matmul(arr6(1,1:n_extent-1:2,m_extent:2:-1),	&
                                               arr7(2,m_extent-1:1:-1,1:k_extent:2))
  call assign_result(1441,1536,arr11,results)
  !print *,"test 2881,3072"
  !print *,arr11
  
  !test 3073-3264
  arr12=0
  arr12(2,n_extent:2:-2,k_extent:2:-2) = matmul(arr6(2,n_extent:2:-2,m_extent-1:1:-1),	&
                                               arr8(m_extent:2:-1,1,k_extent:2:-2))
  call assign_result(1537,1632,arr12,results)
  !print *,"test 3073,3264"
  !print *,arr12
  
  arr16 = (0,0)

  !test 1633-1680
  arr15=0
  arr15 = arr16 +  matmul(arr13,arr14)
  call assign_result(1633,1680,arr15,results)
  !print *,"test 1633,1680"
  !print *,arr15

  call check(results, expect, NbrTests*2)

end program

subroutine assign_result(s_idx, e_idx , arr, rslt)
  COMPLEX*8, dimension(1:e_idx-s_idx+1) :: arr
  COMPLEX*8, dimension(e_idx) :: rslt
  integer:: s_idx, e_idx

  rslt(s_idx:e_idx) = arr

end subroutine
