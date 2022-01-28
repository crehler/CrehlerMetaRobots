echo -e "\e[92m######################################################################"
echo -e "\e[92m#                                                                    #"
echo -e "\e[92m#                      Start CrehlerMetaRobots Builder               #"
echo -e "\e[92m#                                                                    #"
echo -e "\e[92m######################################################################"

echo -e "Release"
echo -e "\e[39m "
echo -e "\e[39m======================================================================"
echo -e "\e[39m "
echo -e "Step 1 of 7 \e[33mRemove old release\e[39m"
# Remove old release
rm -rf CrehlerMetaRobots CrehlerMetaRobots-*.zip
echo -e "\e[32mOK"

echo -e "\e[39m "
echo -e "\e[39m======================================================================"
echo -e "\e[39m "
echo -e "Step 2 of 7 \e[33mCopy files\e[39m"
cd ../../../
./psh.phar storefront:build
./psh.phar administration:build
cd custom/plugins/CrehlerMetaRobots/
echo -e "\e[32mOK"

echo -e "\e[39m "
echo -e "\e[39m======================================================================"
echo -e "\e[39m "
echo -e "Step 2 of 7 \e[33mCopy files\e[39m"
rsync -av --progress . CrehlerMetaRobots --exclude CrehlerMetaRobots
echo -e "\e[32mOK"


echo -e "\e[39m "
echo -e "\e[39m======================================================================"
echo -e "\e[39m "
echo -e "Step 3 of 7 \e[33mGo to directory\e[39m"
cd CrehlerMetaRobots
echo -e "\e[32mOK"

echo -e "\e[39m "
echo -e "\e[39m======================================================================"
echo -e "\e[39m "
echo -e "Step 5 of 7 \e[33mDeleting unnecessary files\e[39m"
cd ..
( find ./CrehlerMetaRobots -type d -name ".git" && find ./CrehlerMetaRobots -name ".gitignore" && find ./CrehlerMetaRobots -name "yarn.lock" && find ./CrehlerMetaRobots -name ".php_cs.dist" &&  find ./CrehlerMetaRobots -name ".gitmodules" && find ./CrehlerMetaRobots -name "build.sh" ) | xargs rm -r
cd CrehlerMetaRobots/src/Resources
rm -rf administration
cd ../../../
echo -e "\e[32mOK"


echo -e "\e[39m "
echo -e "\e[39m======================================================================"
echo -e "\e[39m "
echo -e "Step 6 of 7 \e[33mCreate ZIP\e[39m"
zip -rq CrehlerMetaRobots-master.zip CrehlerMetaRobots
echo -e "\e[32mOK"

echo -e "\e[39m "
echo -e "\e[39m======================================================================"
echo -e "\e[39m "
echo -e "Step 7 of 7 \e[33mClear build directory\e[39m"
rm -rf CrehlerMetaRobots
echo -e "\e[32mOK"


echo -e "\e[92m######################################################################"
echo -e "\e[92m#                                                                    #"
echo -e "\e[92m#                        Build Complete                              #"
echo -e "\e[92m#                                                                    #"
echo -e "\e[92m######################################################################"
echo -e "\e[39m "
echo "   _____          _     _           ";
echo "  / ____|        | |   | |          ";
echo " | |     _ __ ___| |__ | | ___ _ __ ";
echo " | |    | '__/ _ \ '_ \| |/ _ \ '__|";
echo " | |____| | |  __/ | | | |  __/ |   ";
echo "  \_____|_|  \___|_| |_|_|\___|_|   ";
echo "                                    ";
echo "
