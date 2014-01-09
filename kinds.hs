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

-- TypeParam must be an Object and not it's own type so you can apply higher-kinded type parameters. A dictionary also requires TypeParameters as values, so it must also be an Object.

data Type
	when Applied
		obj *Object
		args List[*Type] -- Monomorphic types have an empty list

data Kind
	when Any
	when Higher
		params List[*Object] -- List of TypeParams or Kinds?
		kind *Kind
	
data Object
	name String
	kind *Kind
	when TypeParam
		kind *Kind
	when Struct
		args List[*Object] -- List of TypeParam
	when Var
		type *Type
		args List[*Object] -- List of TypeParam

data Result
	when Value
		type *Type
	when Type
		type *Type
	when Unknown  -- Convert to Result.Type/Value on demand
	 			  -- Can refer to typeclasses
		obj *Object
		args List[*Type] -- Type parameters to the parents of obj
	
