pragma solidity ^0.4.17;

//다양한 테스팅 도구 제공
import "truffle/Assert.sol";
//이미 서버에 배포된 계약 주소를 가져온다. 
import "truffle/DeployedAddresses.sol";
//계약 소스를 가져온다. 
import "../contracts/Adoption.sol";

contract TestAdoption {
    //Adoption 초기화
    Adoption adoption = Adoption(DeployedAddresses.Adoption());

    //Pet에 Adopt를 할수 있는지 테스트
    function testUserCanAdoptPet() public {
        //8번 아이디를 adopt 함수 실행
        uint returnedId = adoption.adopt(8);

        uint expected = 8;


        //값이 제대로 가져오는 지 체크
        Assert.equal(returnedId, expected, "Adoption of pet ID 8 should be recoreded");
    }

    //아이디를 통해 Adopter 주소를 가져오는 걸 테스팅
    function testGetAdopterAddressByPetId() public {
        //트랙잭션을 할 예정이므로 예상 값을 this로 설정 가능하다. (펫 구매한 사람 주소)
        address expected = this;

        //adopters 변수 설정되면 public getter 가 되므로 거기 위치에 8의 값을 가져와서 테스팅해본다. 
        address adopter = adoption.adopters(8);

        //값 맞게 들어오는지 체크
        Assert.equal(adopter, expected, "Owner of pet Id 8 should be recored");
    }

    function testGetAdopterAddressByPetIdInArray() public {
        //트랙잭션을 할 예정이므로 예상 값을 this로 설정 가능하다. (펫 구매한 사람 주소)
        address expected = this;

        //storeage, memory 를 설정해서 실제 물리적으로 저장 할 것인지 내부에서 저장할 건지 정한다. 
        //adoption 클래스에서 adopter 배열목록을 가져온다. 
        address[16] memory adopters = adoption.getAdopters();

        //가져온 adopter의 8번째가 맞는지 체크
        Assert.equal(adopters[8], expected, "Owner of pet ID 8 should be recorded.");
    }
}