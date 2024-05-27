namespace Quiz.Task.Service.RequestDtos
{
    // study set
    public record CreateStudySetDto(string StudySetName, int UserId, List<CreateCardDto> Cards);
    public record UpdateStudySetDto(int Id, string StudySetName, List<UpdateCardDto> Cards);
    // card
    public record CreateCardDto(string Term, string Definition);
    public record UpdateCardDto(int Id, string Term, string Definition, int Task);
    //Class 
    public record CreateClassDto(string ClassName, string Description, int UserId);
    public record UpdateClassDto(int Id, string ClassName, string Description);
    //Folder
    public record CreateFolderDto(string FolderName, int UserId, int ClassId);
    public record UpdateFolderDto(int Id, string FolderName, int ClassId);

    //Folder Detail
    public record CreateFolderDetailDto(int FolderId, int StudySetId);
    //Member
    public record CreateMemberDto(int ClassId, int UserId);

}