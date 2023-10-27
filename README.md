# Feature-Based Occupancy Map-Merging for Collaborative SLAM
When given two overlapping 2D occupancy grid maps, the map-merging establishes an association between the individual maps and fuses them to construct a global map of the environment. This repo presents a map fusion approach based on image key points implemented in Matlab. The figure below gives an overview.
 
![Overview](Resources/overview.png)

### About the implementation:
- This is a simple Matlab implementation that requires Matlab's Computer Vision Toolbox.
- The code is only for demonstration; some parts may be inefficient. 
- To get started, just run: 
```
Occupancy-Grid-Map-Fusion/mapFusionMAIN.m
```
For more details, please refer to the [MDPI journal](https://www.mdpi.com/1424-8220/23/6/3114).
