// SPDX-License-Identifier: MIT

// File: @openzeppelin/contracts/token/ERC20/IERC20.sol

pragma solidity ^0.5.0;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP. Does not include
 * the optional functions; to access them see `ERC20Detailed`.
 */
interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a `Transfer` event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through `transferFrom`. This is
     * zero by default.
     *
     * This value changes when `approve` or `transferFrom` are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * > Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an `Approval` event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a `Transfer` event.
     */
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to `approve`. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

// File: @openzeppelin/contracts/math/SafeMath.sol

pragma solidity ^0.5.0;

/**
 * @dev Wrappers over Solidity's arithmetic operations with added overflow
 * checks.
 *
 * Arithmetic operations in Solidity wrap on overflow. This can easily result
 * in bugs, because programmers usually assume that an overflow raises an
 * error, which is the standard behavior in high level programming languages.
 * `SafeMath` restores this intuition by reverting the transaction when an
 * operation overflows.
 *
 * Using this library instead of the unchecked operations eliminates an entire
 * class of bugs, so it's recommended to use it always.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "SafeMath: subtraction overflow");
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        // Solidity only automatically asserts when dividing by 0
        require(b > 0, "SafeMath: division by zero");
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b != 0, "SafeMath: modulo by zero");
        return a % b;
    }
}

// File: @openzeppelin/contracts/utils/Address.sol

pragma solidity ^0.5.0;

/**
 * @dev Collection of functions related to the address type,
 */
library Address {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * This test is non-exhaustive, and there may be false-negatives: during the
     * execution of a contract's constructor, its address will be reported as
     * not containing a contract.
     *
     * > It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     */
    function isContract(address account) internal view returns (bool) {
        // This method relies in extcodesize, which returns 0 for contracts in
        // construction, since the code is only stored at the end of the
        // constructor execution.

        uint256 size;
        // solhint-disable-next-line no-inline-assembly
        assembly { size := extcodesize(account) }
        return size > 0;
    }
}

// File: @openzeppelin/contracts/token/ERC20/SafeERC20.sol

pragma solidity ^0.5.0;




/**
 * @title SafeERC20
 * @dev Wrappers around ERC20 operations that throw on failure (when the token
 * contract returns false). Tokens that return no value (and instead revert or
 * throw on failure) are also supported, non-reverting calls are assumed to be
 * successful.
 * To use this library you can add a `using SafeERC20 for ERC20;` statement to your contract,
 * which allows you to call the safe operations as `token.safeTransfer(...)`, etc.
 */
library SafeERC20 {
    using SafeMath for uint256;
    using Address for address;

    function safeTransfer(IERC20 token, address to, uint256 value) internal {
        callOptionalReturn(token, abi.encodeWithSelector(token.transfer.selector, to, value));
    }

    function safeTransferFrom(IERC20 token, address from, address to, uint256 value) internal {
        callOptionalReturn(token, abi.encodeWithSelector(token.transferFrom.selector, from, to, value));
    }

    function safeApprove(IERC20 token, address spender, uint256 value) internal {
        // safeApprove should only be called when setting an initial allowance,
        // or when resetting it to zero. To increase and decrease it, use
        // 'safeIncreaseAllowance' and 'safeDecreaseAllowance'
        // solhint-disable-next-line max-line-length
        require((value == 0) || (token.allowance(address(this), spender) == 0),
            "SafeERC20: approve from non-zero to non-zero allowance"
        );
        callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, value));
    }

    function safeIncreaseAllowance(IERC20 token, address spender, uint256 value) internal {
        uint256 newAllowance = token.allowance(address(this), spender).add(value);
        callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
    }

    function safeDecreaseAllowance(IERC20 token, address spender, uint256 value) internal {
        uint256 newAllowance = token.allowance(address(this), spender).sub(value);
        callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
    }

    /**
     * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement
     * on the return value: the return value is optional (but if data is returned, it must not be false).
     * @param token The token targeted by the call.
     * @param data The call data (encoded using abi.encode or one of its variants).
     */
    function callOptionalReturn(IERC20 token, bytes memory data) private {
        // We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since
        // we're implementing it ourselves.

        // A Solidity high level call has three parts:
        //  1. The target address is checked to verify it contains contract code
        //  2. The call itself is made, and success asserted
        //  3. The return value is decoded, which in turn checks the size of the returned data.
        // solhint-disable-next-line max-line-length
        require(address(token).isContract(), "SafeERC20: call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = address(token).call(data);
        require(success, "SafeERC20: low-level call failed");

        if (returndata.length > 0) { // Return data is optional
            // solhint-disable-next-line max-line-length
            require(abi.decode(returndata, (bool)), "SafeERC20: ERC20 operation did not succeed");
        }
    }
}

// File: @openzeppelin/contracts/ownership/Ownable.sol

pragma solidity ^0.5.0;

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be aplied to your functions to restrict their use to
 * the owner.
 */
contract Ownable {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor () internal {
        _owner = msg.sender;
        emit OwnershipTransferred(address(0), _owner);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(isOwner(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Returns true if the caller is the current owner.
     */
    function isOwner() public view returns (bool) {
        return msg.sender == _owner;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * > Note: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public onlyOwner {
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     */
    function _transferOwnership(address newOwner) internal {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

// File: @openzeppelin/contracts/token/ERC20/ERC20.sol

pragma solidity ^0.5.0;



/**
 * @dev Implementation of the `IERC20` interface.
 *
 * This implementation is agnostic to the way tokens are created. This means
 * that a supply mechanism has to be added in a derived contract using `_mint`.
 * For a generic mechanism see `ERC20Mintable`.
 *
 * *For a detailed writeup see our guide [How to implement supply
 * mechanisms](https://forum.zeppelin.solutions/t/how-to-implement-erc20-supply-mechanisms/226).*
 *
 * We have followed general OpenZeppelin guidelines: functions revert instead
 * of returning `false` on failure. This behavior is nonetheless conventional
 * and does not conflict with the expectations of ERC20 applications.
 *
 * Additionally, an `Approval` event is emitted on calls to `transferFrom`.
 * This allows applications to reconstruct the allowance for all accounts just
 * by listening to said events. Other implementations of the EIP may not emit
 * these events, as it isn't required by the specification.
 *
 * Finally, the non-standard `decreaseAllowance` and `increaseAllowance`
 * functions have been added to mitigate the well-known issues around setting
 * allowances. See `IERC20.approve`.
 */
contract ERC20 is IERC20 {
    using SafeMath for uint256;

    mapping (address => uint256) private _balances;

    mapping (address => mapping (address => uint256)) private _allowances;

    uint256 private _totalSupply;

    /**
     * @dev See `IERC20.totalSupply`.
     */
    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    /**
     * @dev See `IERC20.balanceOf`.
     */
    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    /**
     * @dev See `IERC20.transfer`.
     *
     * Requirements:
     *
     * - `recipient` cannot be the zero address.
     * - the caller must have a balance of at least `amount`.
     */
    function transfer(address recipient, uint256 amount) public returns (bool) {
        _transfer(msg.sender, recipient, amount);
        return true;
    }

    /**
     * @dev See `IERC20.allowance`.
     */
    function allowance(address owner, address spender) public view returns (uint256) {
        return _allowances[owner][spender];
    }

    /**
     * @dev See `IERC20.approve`.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function approve(address spender, uint256 value) public returns (bool) {
        _approve(msg.sender, spender, value);
        return true;
    }

    /**
     * @dev See `IERC20.transferFrom`.
     *
     * Emits an `Approval` event indicating the updated allowance. This is not
     * required by the EIP. See the note at the beginning of `ERC20`;
     *
     * Requirements:
     * - `sender` and `recipient` cannot be the zero address.
     * - `sender` must have a balance of at least `value`.
     * - the caller must have allowance for `sender`'s tokens of at least
     * `amount`.
     */
    function transferFrom(address sender, address recipient, uint256 amount) public returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, msg.sender, _allowances[sender][msg.sender].sub(amount));
        return true;
    }

    /**
     * @dev Atomically increases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to `approve` that can be used as a mitigation for
     * problems described in `IERC20.approve`.
     *
     * Emits an `Approval` event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function increaseAllowance(address spender, uint256 addedValue) public returns (bool) {
        _approve(msg.sender, spender, _allowances[msg.sender][spender].add(addedValue));
        return true;
    }

    /**
     * @dev Atomically decreases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to `approve` that can be used as a mitigation for
     * problems described in `IERC20.approve`.
     *
     * Emits an `Approval` event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     * - `spender` must have allowance for the caller of at least
     * `subtractedValue`.
     */
    function decreaseAllowance(address spender, uint256 subtractedValue) public returns (bool) {
        _approve(msg.sender, spender, _allowances[msg.sender][spender].sub(subtractedValue));
        return true;
    }

    /**
     * @dev Moves tokens `amount` from `sender` to `recipient`.
     *
     * This is internal function is equivalent to `transfer`, and can be used to
     * e.g. implement automatic token fees, slashing mechanisms, etc.
     *
     * Emits a `Transfer` event.
     *
     * Requirements:
     *
     * - `sender` cannot be the zero address.
     * - `recipient` cannot be the zero address.
     * - `sender` must have a balance of at least `amount`.
     */
    function _transfer(address sender, address recipient, uint256 amount) internal {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");

        _balances[sender] = _balances[sender].sub(amount);
        _balances[recipient] = _balances[recipient].add(amount);
        emit Transfer(sender, recipient, amount);
    }

    /** @dev Creates `amount` tokens and assigns them to `account`, increasing
     * the total supply.
     *
     * Emits a `Transfer` event with `from` set to the zero address.
     *
     * Requirements
     *
     * - `to` cannot be the zero address.
     */
    function _mint(address account, uint256 amount) internal {
        require(account != address(0), "ERC20: mint to the zero address");

        _totalSupply = _totalSupply.add(amount);
        _balances[account] = _balances[account].add(amount);
        emit Transfer(address(0), account, amount);
    }

     /**
     * @dev Destoys `amount` tokens from `account`, reducing the
     * total supply.
     *
     * Emits a `Transfer` event with `to` set to the zero address.
     *
     * Requirements
     *
     * - `account` cannot be the zero address.
     * - `account` must have at least `amount` tokens.
     */
    function _burn(address account, uint256 value) internal {
        require(account != address(0), "ERC20: burn from the zero address");

        _totalSupply = _totalSupply.sub(value);
        _balances[account] = _balances[account].sub(value);
        emit Transfer(account, address(0), value);
    }

    /**
     * @dev Sets `amount` as the allowance of `spender` over the `owner`s tokens.
     *
     * This is internal function is equivalent to `approve`, and can be used to
     * e.g. set automatic allowances for certain subsystems, etc.
     *
     * Emits an `Approval` event.
     *
     * Requirements:
     *
     * - `owner` cannot be the zero address.
     * - `spender` cannot be the zero address.
     */
    function _approve(address owner, address spender, uint256 value) internal {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = value;
        emit Approval(owner, spender, value);
    }

    /**
     * @dev Destoys `amount` tokens from `account`.`amount` is then deducted
     * from the caller's allowance.
     *
     * See `_burn` and `_approve`.
     */
    function _burnFrom(address account, uint256 amount) internal {
        _burn(account, amount);
        _approve(account, msg.sender, _allowances[account][msg.sender].sub(amount));
    }
}

// File: @openzeppelin/contracts/token/ERC20/ERC20Detailed.sol

pragma solidity ^0.5.0;


/**
 * @dev Optional functions from the ERC20 standard.
 */
contract ERC20Detailed is IERC20 {
    string private _name;
    string private _symbol;
    uint8 private _decimals;

    /**
     * @dev Sets the values for `name`, `symbol`, and `decimals`. All three of
     * these values are immutable: they can only be set once during
     * construction.
     */
    constructor (string memory name, string memory symbol, uint8 decimals) public {
        _name = name;
        _symbol = symbol;
        _decimals = decimals;
    }

    /**
     * @dev Returns the name of the token.
     */
    function name() public view returns (string memory) {
        return _name;
    }

    /**
     * @dev Returns the symbol of the token, usually a shorter version of the
     * name.
     */
    function symbol() public view returns (string memory) {
        return _symbol;
    }

    /**
     * @dev Returns the number of decimals used to get its user representation.
     * For example, if `decimals` equals `2`, a balance of `505` tokens should
     * be displayed to a user as `5,05` (`505 / 10 ** 2`).
     *
     * Tokens usually opt for a value of 18, imitating the relationship between
     * Ether and Wei.
     *
     * > Note that this information is only used for _display_ purposes: it in
     * no way affects any of the arithmetic of the contract, including
     * `IERC20.balanceOf` and `IERC20.transfer`.
     */
    function decimals() public view returns (uint8) {
        return _decimals;
    }
}

// File: internal/HTCToken.sol

pragma solidity >=0.5.0 <0.8.0;




contract HTCToken is ERC20, ERC20Detailed, Ownable {
    address private _minter;
    modifier onlyMinter() {
        require(msg.sender == _minter, "only minter");
        _;
    }
    event MinterChanged(address indexed oldMinter, address indexed newMinter);

    constructor() ERC20Detailed("HTCToken", "HTC", 18) public {
    }

    function mint(address to, uint256 amount) external onlyMinter {
        _mint(to, amount);
    }

    function minter() public view returns (address) {
        return _minter;
    }

    function changeMinter(address newMinter) public onlyOwner {
        require(newMinter != address(0), "new minter is the zero address");
        emit MinterChanged(_minter, newMinter);
        _minter = newMinter;
    }
}

// File: internal/HtswapMaster.sol

pragma solidity >=0.5.0 <0.8.0;






// Reward is ERC20 token which support mint and can not rebase
contract HtswapMaster is Ownable {
    using SafeMath for uint256;
    using SafeERC20 for IERC20;

    struct CustomerStatus {
        uint256 amount;
        uint256 rewardArrear;
    }

    struct PoolStatus {
        IERC20 liquidity;
        uint256 weight;
        uint256 lastRewardBlock;
        uint256 growthRewardPerStake;
    }

    struct RewardLockStatus {
        uint256 locked;
        uint256 lastUnlockTime;
    }

    uint256 public growthRewardCoefficient;

    HTCToken public rewardToken;
    uint256 public rewardPerBlock;
    address public devRewardAddr;
    address public commRewardAddr;
    uint256 public scaleDownEpoch;
    uint256 public scaleDownRate;
    uint256 public lastScaleDownBlock;
    uint256 public rewardLockPeriod; // seconds

    PoolStatus[] public poolStatus;
    mapping (address => uint256) public poolIndex;
    mapping (uint256 => mapping (address => CustomerStatus)) public customerStatus;
    mapping (uint256 => mapping (address => RewardLockStatus)) public rewardLockStatus;
    uint256 public totalWeight = 0;
    uint256 public launchBlock;

    event Deposit(address indexed customer, uint256 indexed pid, uint256 amount);
    event Withdraw(address indexed customer, uint256 indexed pid, uint256 amount);
    event MustWithdraw(address indexed customer, uint256 indexed pid, uint256 amount);

    constructor(
        HTCToken _rewardToken,
        uint256 _launchBlock,
        uint256 _rewardPerBlock,
        uint256 _growthRewardCoefficient
    ) public {
        rewardToken = _rewardToken;
        launchBlock = _launchBlock > 0 ? _launchBlock : block.number;
        rewardPerBlock = _rewardPerBlock;
        growthRewardCoefficient = _growthRewardCoefficient > 0 ? _growthRewardCoefficient : 1e12;
    }

    function getPoolLength() external view returns (uint256) {
        return poolStatus.length;
    }

    function setRewardPerBlock(uint256 _rewardPerBlock, bool _withUpdate) public onlyOwner {
        if (_withUpdate) {
            updateAllPoolStatus();
        }
        rewardPerBlock = _rewardPerBlock;
    }

    function setRewardLockPeriod(uint256 _period) public onlyOwner {
        rewardLockPeriod = _period;
    }

    function setScaleDown(uint256 _start, uint256 _scaleDownEpoch, uint256 _scaleDownRate) public onlyOwner {
        require(block.number < _start.add(_scaleDownEpoch), "passed epoch");
        lastScaleDownBlock = _start;
        scaleDownEpoch = _scaleDownEpoch;
        scaleDownRate = _scaleDownRate;
    }

    function setDevCommRewardAddr(address _devRewardAddr, address _commRewardAddr) public onlyOwner {
        require(_devRewardAddr != address(0), "zero dev address");
        require(_commRewardAddr != address(0), "zero comm address");
        devRewardAddr = _devRewardAddr;
        commRewardAddr = _commRewardAddr;
    }

    function addPool(uint256 _weight, IERC20 _liquidity, bool _withUpdate) public onlyOwner {
        require(poolIndex[address(_liquidity)] == 0, "exist");
        if (_withUpdate) {
            updateAllPoolStatus();
        }
        uint256 lastRewardBlock = block.number > launchBlock ? block.number : launchBlock;
        totalWeight = totalWeight.add(_weight);
        poolStatus.push(PoolStatus({
            liquidity: _liquidity,
            weight: _weight,
            lastRewardBlock: lastRewardBlock,
            growthRewardPerStake: 0
        }));
        poolIndex[address(_liquidity)] = poolStatus.length;
    }

    function updatePoolSetting(uint256 _pid, uint256 _weight, bool _withUpdate) public onlyOwner {
        if (_withUpdate) {
            updateAllPoolStatus();
        }
        totalWeight = totalWeight.sub(poolStatus[_pid].weight).add(_weight);
        poolStatus[_pid].weight = _weight;
    }

    function getPendingReward(uint256 _pid, address _customer) external view returns (uint256) {
        PoolStatus storage pool = poolStatus[_pid];
        CustomerStatus storage customer = customerStatus[_pid][_customer];
        uint256 growthRewardPerStake = pool.growthRewardPerStake;
        uint256 lpSupply = pool.liquidity.balanceOf(address(this));
        if (block.number > pool.lastRewardBlock && lpSupply != 0) {
            uint256 factor = block.number.sub(pool.lastRewardBlock);
            uint256 tokenReward = factor.mul(rewardPerBlock).mul(pool.weight).div(totalWeight);
            uint256 devReward = tokenReward.div(10);
            uint256 poolReward = tokenReward.sub(devReward.mul(2));
            growthRewardPerStake = growthRewardPerStake.add(poolReward.mul(growthRewardCoefficient).div(lpSupply));
        }
        return customer.amount.mul(growthRewardPerStake).div(growthRewardCoefficient).sub(customer.rewardArrear);
    }

    function updateAllPoolStatus() public {
        uint256 length = poolStatus.length;
        for (uint256 pid = 0; pid < length; ++pid) {
            updatePoolStatus(pid);
        }
    }

    function updateScaleDown() public {
        if (scaleDownEpoch == 0 || scaleDownRate == 100) {
            return;
        }
        while (block.number >= lastScaleDownBlock.add(scaleDownEpoch)) {
            lastScaleDownBlock = lastScaleDownBlock.add(scaleDownEpoch);
            rewardPerBlock = rewardPerBlock.mul(scaleDownRate).div(100);
        }
    }

    function updatePoolStatus(uint256 _pid) public {
        updateScaleDown();
        PoolStatus storage pool = poolStatus[_pid];
        if (block.number <= pool.lastRewardBlock) {
            return;
        }
        uint256 lpSupply = pool.liquidity.balanceOf(address(this));
        uint256 factor = block.number.sub(pool.lastRewardBlock);
        uint256 tokenReward = factor.mul(rewardPerBlock).mul(pool.weight).div(totalWeight);
        if (tokenReward > 0 && lpSupply > 0) {
            uint256 devReward = tokenReward.div(10);
            uint256 poolReward = tokenReward.sub(devReward);
            rewardToken.mint(devRewardAddr, devReward);
            rewardToken.mint(commRewardAddr, devReward);
            rewardToken.mint(address(this), poolReward);
            pool.growthRewardPerStake = pool.growthRewardPerStake.add(poolReward.mul(growthRewardCoefficient).div(lpSupply));
        }
        pool.lastRewardBlock = block.number;
    }

    function _harvest(PoolStatus storage pool, CustomerStatus storage customer, RewardLockStatus storage lockStat) internal {
            uint256 harvest = 0;
            if (rewardLockPeriod == 0 || block.timestamp > lockStat.lastUnlockTime.add(rewardLockPeriod)) {
                harvest = lockStat.locked;
                lockStat.locked = 0;
                lockStat.lastUnlockTime = block.timestamp;
            }
            uint256 pending = customer.amount.mul(pool.growthRewardPerStake).div(growthRewardCoefficient).sub(customer.rewardArrear);
            if(pending > 0) {
                uint256 locking = pending.div(2);
                harvest = harvest.add(pending.sub(locking));
                lockStat.locked = lockStat.locked.add(locking);
            }
            if (harvest > 0) {
                safeHarvest(msg.sender, harvest);
            }
    }

    function deposit(uint256 _pid, uint256 _amount) public {
        PoolStatus storage pool = poolStatus[_pid];
        CustomerStatus storage customer = customerStatus[_pid][msg.sender];
        updatePoolStatus(_pid);
        if (customer.amount > 0) {
            _harvest(pool, customer, rewardLockStatus[_pid][msg.sender]);
        }
        if(_amount > 0) {
            pool.liquidity.safeTransferFrom(address(msg.sender), address(this), _amount);
            customer.amount = customer.amount.add(_amount);
        }
        customer.rewardArrear = customer.amount.mul(pool.growthRewardPerStake).div(growthRewardCoefficient);
        emit Deposit(msg.sender, _pid, _amount);
    }

    function withdraw(uint256 _pid, uint256 _amount) public {
        PoolStatus storage pool = poolStatus[_pid];
        CustomerStatus storage customer = customerStatus[_pid][msg.sender];
        require(customer.amount >= _amount, "withdraw: not good");
        updatePoolStatus(_pid);
        if (customer.amount > 0) {
            _harvest(pool, customer, rewardLockStatus[_pid][msg.sender]);
        }
        if(_amount > 0) {
            customer.amount = customer.amount.sub(_amount);
            pool.liquidity.safeTransfer(address(msg.sender), _amount);
        }
        customer.rewardArrear = customer.amount.mul(pool.growthRewardPerStake).div(growthRewardCoefficient);
        emit Withdraw(msg.sender, _pid, _amount);
    }

    function mustWithdraw(uint256 _pid) public {
        PoolStatus storage pool = poolStatus[_pid];
        CustomerStatus storage customer = customerStatus[_pid][msg.sender];
        uint256 amount = customer.amount;
        customer.amount = 0;
        customer.rewardArrear = 0;
        pool.liquidity.safeTransfer(address(msg.sender), amount);
        emit MustWithdraw(msg.sender, _pid, amount);
    }

    function safeHarvest(address _to, uint256 _amount) internal {
        uint256 rewardTokenBal = rewardToken.balanceOf(address(this));
        if (_amount > rewardTokenBal) {
            _amount = rewardTokenBal;
        }
        rewardToken.transfer(_to, _amount);
    }

}
