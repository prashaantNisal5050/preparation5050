# strong paramerter concept-
  params.require(:user).permit(:name, :email)
  and say "We whitelist parameters at the controller layer."
#