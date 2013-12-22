data Value -- An actual value
	mem List[byte]

data Type
	when ValueAsType -- Value passed as a type (in fixed size arrays for example)
		val *Value
	when Variable  -- Unifiable type variable
		instance *Type?
	when Ref -- Type variable which can't be unified. Used for type parameters
		obj *Object -- A TypeParam of kind AnyType
		args List[*Type] -- When there's no list, the kind is AnyType -- args should be able to contain references to Object without any arguments applied
	when Applied -- An object of HigherKind which returns a kind *HigherKind.kind when applied with 'args'
		obj *Object
		args List[*Type]
	
data Kind
	when ValueKind
		type *Type
	when AnyType -- A regular type. Corresponds to Haskell's *
	when HigherKind
		params List[*TypeParam] -- List of TypeParams
		kind *Kind
		
data TypeParam
	kind *Kind
	
data Struct
	kind *Kind
	
data Object
	when ObjTypeParam
		param TypeParam
	when ObjStruct
		struct Struct
	
-- Simple, no value type parameters

data Type
	Param TypeParam       -- Explicit type parameter
	Applied Object [Type] -- Monomorphic types have an empty list

data Kind
	AnyType
	Higher [Kind] Kind
	
data TypeParam
	TypeParam Name Kind

data Object
	Struct [TypeParam]
	Var Type [TypeParam]

data InferenceResult
	ValueResult Type
	TypeResult Type
	KindResult Object -- Convert to TypeResult on demand
	
