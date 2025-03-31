https://github.com/binmenja/modtran6-beluga

# This repository is intended to help new MODTRAN6.0 users.




## Appendix

In order to make the usage of Modtran easier, one can use a tape5 maker. In this repository "modtran6_tape5_maker.m" is an example wrapper to generate the tape5 necessary to the computation of the radiative transfer equation.




## Installation

A complete guide of the installation of Modtran6 on Alliance Canada servers is available upon demand on the atmospheric radiation group website of McGill University (https://huanggroup.wordpress.com/home/). If you'd like access, please contact Professor Yi Huang (yi.huang@mcgill.ca) and Benjamin Riot--Bretêcher (benjamin.riotbretecher@mail.mcgill.ca). Please note this guide would only be provided to people working with this research group.
    
## Run the model

The tape 5 is the file containing the different variables of the atmospheric profiles for which the user is willing to do a simulation as well as the model configuration. The input profile can be model outputs, radiosonde profiles, or any other atmospheric profile variables. Please note Modtran is usually expecting you to provide atmospheric gases concentration unless you are using a standard profile (see the manual). An example file to use an abritrary profile, run the model and save the output is shown in "run_modtran_example.m". This file also contains a line generating a quick plot for you to observe the output results. 
## Acknowledgements
Special thanks to Dr. Jing Feng who worked hard during her PhD to create different wrappers and bring a lot of knowledge to our group. This work was also inspired from her GitHub repo:
 - [Dr. Jing Feng GitHub page about Modtran 6](https://github.com/fengzydy/modtran6_wrapper)
 


## Authors

- [@binmenja](https://github.com/binmenja)
- [@fengzydy](https://github.com/fengzydy)