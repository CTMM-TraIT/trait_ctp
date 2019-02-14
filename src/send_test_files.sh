for i in {1..10}
do
dcmodify -nb -gin "orig.dcm"
storescu -v localhost 104 "orig.dcm"
done