// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "https://github.com/ConsenSysMesh/openzeppelin-solidity/blob/master/contracts/math/SafeMath.sol";

contract RealEstate {
    using SafeMath for uint256;

    struct Property {
        uint256 price;
        address owner;
        bool forSale;
        string name;
        string location;
        string description;
    }

    mapping(uint256 => Property) public properties;

    uint256[] public propertiesID;

    event PropertySold(uint256 propertyID);

    function listPropertyForSale(
        uint256 _propertyID,
        string memory _name,
        string memory _description,
        string memory _location,
        address _owner,
        uint256 _price
    ) public {
        Property memory property = Property({
            name: _name,
            owner: _owner,
            description: _description,
            forSale: true,
            price: _price,
            location: _location
        });

        properties[_propertyID] = property;
        propertiesID.push(_propertyID);
    }

    function buyProperty(string memory _propertyID) public payable {
        Property memory property = properties[_propertyID];

        require(property.forSale,'Property not available for sale!');
        require(msg.value <= property.price,'Insufficient fund to buy property!');
        property.owner = msg.sender;
        property.forSale = false;
        payable(property.owner).transfer(property.price);

        emit PropertySold(_propertyID);
    }
}

