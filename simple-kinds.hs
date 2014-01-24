-- Simple, no value type parameters, no multiple type parameter applications (List[A][B])

-- TypeParam must be an Object and not it's own type so you can apply higher-kinded type parameters. A dictionary also requires TypeParameters as values, so it must also be an Object.

data Type
	when Variable  -- Unifiable type variable
		instance *Type?
	when Applied
		obj *Object
		args List[*Type] -- Monomorphic types have an empty list

data EqLimit
	type_func *Object
	val *Type

data TypeclassLimit
	typeclass *Object
	args List[*Type]
	limits List[*EqLimit]

data TypeContext
	limits List[*TypeclassLimit]

data Object
	name String
	params List[*Object] -- List of TypeParams. Empty means no type parameters are required
	ctx TypeContext -- It's limits should be empty when there are no type parameters (It might have entries if any parent has type parameters)
	type *Type
	scope *Scope? -- TypeParam and Var needs a scope to declare type parameters in. Struct and Typeclass always gets a scope
	when TypeParam
		value bool
	when Struct
	when Typeclass
	when Var

data Result
	when Value
		type *Type
	when Type
		type *Type
	when Unknown  -- Convert to Result.Type/Value on demand
	 			  -- Can refer to typeclasses
	 			  -- Just point to Type here too?
		obj *Object
		args List[*Type] -- Type parameters to the parents of obj. Is this required? All type parameters to parents should be in scope?


-- Type contexts and type parameters, type context of type parameters?

data Hello[A] where Num[A]

data Test[Param[T] where Callable[T]]

main()
	.var Test[Hello] -- How to verify that this is invalid?
