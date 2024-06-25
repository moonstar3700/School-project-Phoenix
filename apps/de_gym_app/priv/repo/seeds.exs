# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     DeGymApp.Repo.insert!(%DeGymApp.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
{:ok, _cs} =
  DeGymApp.EmployeeContext.create_employee(%{"email" => "Trainer@trainer.be", "firstname" =>
  "Trainer", "function" => "Trainer", "lastname" => "Trainer", "unsave_password" => "t"})

{:ok, _cs} =
  DeGymApp.EmployeeContext.create_employee(%{"email" => "Manager@manager.be", "firstname" =>
  "Manager", "function" => "Trainer", "lastname" => "Manager", "unsave_password" => "t"})

{:ok, _cs} =
  DeGymApp.ClientContext.create_client(%{
    "adress" => "Tiensestraat 10",
    "email" => "client1@gym.be",
    "firstname" => "John",
    "lastname" => "Johnson",
    "municipal" => "Leuven",
    "phone_nr" => "123-456-7898"})

{:ok, _cs} =
  DeGymApp.ClientContext.create_client(%{
    "adress" => "Tiensestraat 10",
    "email" => "client2@gym.be",
    "firstname" => "Jolie",
    "lastname" => "Johnson",
    "municipal" => "Leuven",
    "phone_nr" => "123-456-7899"})

{:ok, _cs} =
  DeGymApp.ClientContext.create_client(%{
    "adress" => "Tiensestraat 10",
    "email" => "client3@gym.be",
    "firstname" => "Josh",
    "lastname" => "Johnson",
    "municipal" => "Leuven",
    "phone_nr" => "123-456-7888"})

{:ok, _cs} =
    DeGymApp.ExerciseContext.create_exercise(%{
      "name" => "push-ups",
      "reps" => 10,
      "sets" => 3,
      "description" => "The push-up is a common calisthenics exercise beginning from the prone position. By raising and lowering the body using the arms, push-ups exercise the pectoral muscles, triceps, and anterior deltoids, with ancillary benefits to the rest of the deltoids, serratus anterior, coracobrachialis and the midsection as a whole."
    })

{:ok, _cs} =
  DeGymApp.ExerciseContext.create_exercise(%{
     "name" => "pull-ups",
     "reps" => 10,
     "sets" => 3,
    "description" => "A pull-up is an upper-body strength exercise. The pull-up is a closed-chain movement where the body is suspended by the hands, gripping a bar or other implement at a distance typically wider than shoulder-width, and pulled up. As this happens, the elbows flex and the shoulders adduct and extend to bring the elbows to the torso."})

{:ok, _cs} =
  DeGymApp.ExerciseContext.create_exercise(%{
     "name" => "sit-ups",
     "reps" => 10,
     "sets" => 3,
    "description" => "The sit-up (or curl-up) is an abdominal endurance training exercise to strengthen, tighten and tone the abdominal muscles. It is similar to a crunch (crunches target the rectus abdominis and also work the external and internal obliques), but sit-ups have a fuller range of motion and condition additional muscles."})

{:ok, _cs} =
  DeGymApp.TrainingContext.create_trainingplan(%{
    "name" => "warmup",
    "level" => "easy",
    "description" => "For beginners"
  })

{:ok, _cs} =
  DeGymApp.TrainingContext.create_trainingplan(%{
    "name" => "abs training",
    "level" => "medium",
    "description" => "For those who like to train regularly"})

{:ok, _cs} =
  DeGymApp.TrainingContext.create_trainingplan(%{
    "name" => "full body workout",
    "level" => "hard",
    "description" => "For those who live in the gym"})
