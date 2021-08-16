pragma solidity ^0.8.0;

//Step 1
//Create a first "ParentVehicle" contract that includes the following functions
//start - returns String message” The Vehicle has just Started”
//accelerate - returns String message” The Vehicle has just Accelerated”
//stop -- returns String message” The Vehicle has just Stopped”
//service- returns String message” The Vehicle is being serviced”



contract parentvehicle{

    

    function Start ()  pure public returns (string memory)  {
        string memory start="The vehicle hass just started";
        return start;
    }
    
    function Accelerate () pure public returns (string memory ){
        string memory accelerate ="The vehicle has just accelerated";
        return accelerate;
    }
    
    function Stop () public pure returns (string memory){
        string memory stop ="The vehicle has just stopped";
        return stop;
    }
    
    function Service () public pure virtual returns (string memory) {
        string memory service ="The vehicle is being serviced" ;
        return service;
    }
}

//step 2 
//Next Create following Child contracts for a different type of vehicles, that inherits Vehicle


//car 
 
  contract Car is parentvehicle{
   function Service() public pure override virtual returns(string memory){
    string memory car = "The car has being serviced";
    return car;
   }
}

//truck

  contract Truck is parentvehicle {
      function Service() public pure override virtual returns(string memory){
       string memory truck = "The truck has being serviced";
       return truck;
      }
  }

//motorcycle

 contract Motorcycle is parentvehicle {
     function Service() public pure override virtual returns(string memory){
         string memory motorcycle = "The Motorcycle has being serviced";
         return motorcycle;
     }
 }
 

//step 3
// create smart contracts for “Alto Mehran, “ Hino, Yamaha, that may inherit the relevant smart contract(s) as in step 2.


// for ALTO Car 
contract Alto is Car{
    function Service() public pure override virtual returns(string memory){
        string memory alto = "The Alto car is being serviced";
        return alto;
    }
}


// for Hino Truck
contract Hino is Truck{
    function Service() public pure override virtual returns(string memory){
        string memory hino = "The Hino Truck is being serviced";
        return hino;
    }
}


//for Yamaha Motorcycle
contract Yamaha is Motorcycle{
    function Service() public pure override virtual returns(string memory){
        string memory yamaha = "The Yamaha motorcycle is being serviced";
        return yamaha;
    }
}

// step 4 
//Create 3 Service Stations for each vehicle type, with the same
//function “vehicleService that takes the address of the deployed
//contracts of step 3, in the “Vehicle” variable to call the service function


// service station for Car
contract serviceStationForCar {
    function Service(address adr) public pure returns(string memory ) {
       Car car = Car(adr);
       return car.Service();
    }
}


// service station for Truck
contract serviceStationForTruck{
     function Service(address adr) public pure returns(string memory ) {
           Truck truck = Truck(adr);
       return truck.Service();
    }
}


// Service station for Motorcycle
contract serviceStationForMotorCycle{
     function Service(address adr) public pure returns(string memory ) {
         Motorcycle motorcycle = Motorcycle(adr);
       return motorcycle.Service();
    }
}

 


